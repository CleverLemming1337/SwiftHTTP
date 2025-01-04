//
//  Routing.swift
//  SwiftHTTP
//
//  Created by CleverLemming on 03.01.25.
//

import Foundation

// Result Builder für Routing
@resultBuilder
public struct RoutingBuilder {
    public static func buildBlock(_ components: RoutingComponent...) -> [RoutingComponent] {
        return components
    }
}

public protocol RoutingComponent {
    var path: String { get }
    var handleRequest: (HTTPRequest, String) -> HTTPResponse { get }
}

// Endpoint für den Routing-Mechanismus
public struct Endpoint: RoutingComponent {
    public let path: String
    public let method: HTTPMethod
    public var handleRequest: (HTTPRequest, String) -> HTTPResponse
    public let processRequest: (HTTPRequest) -> HTTPResponse // This makes creating endpoints more comforting so you just write `request in` instead of `request, _ in`
    
    public init(method: HTTPMethod = .get, _ path: String = "", _ processRequest: @escaping (HTTPRequest) -> HTTPResponse) {
        self.method = method
        self.path = path
        self.processRequest = processRequest
        self.handleRequest = { _, _ in HTTPResponse(status: .httpInternalServerError, "Internal server error") } // complete initializer first before accessing `self`
        
        
        self.handleRequest = { [self] request, _ in
            if request.method == .head && method == .get {
                return self.processRequest(request).removingBody()
            }
            if request.method == .options {
                return HTTPResponse(headers: ["Content-Type": "application/json"], "[\"\(method.rawValue)\"]")
            }
            if request.method == method {
                return self.processRequest(request)
            }
            return HTTPResponse(status: .httpMethodNotAllowed, "Method not allowed")
        }
    }
}

// Route für die Gruppierung von Endpoints
public struct Route: RoutingComponent {
    public let path: String
    public let routing: [RoutingComponent]
    
    public init(_ path: String, @RoutingBuilder builder: () -> [RoutingComponent]) {
        self.path = path
        self.routing = builder()
        
        handleRequest = { _, _ in HTTPResponse(status: .httpInternalServerError, "Internal server error") } // complete initializer first before accessing `self`
        
        handleRequest = { [self] request, path in
            let path = (path.trimmingCharacters(in: CharacterSet(charactersIn: "/"))+"/").split(separator: "/")[1...].joined(separator: "/")
            for routingComponent in routing {
                if path == routingComponent.path {
                    return routingComponent.handleRequest(request, path)
                }
            }
            return HTTPResponse(status: .httpNotFound, "Not found")
        }
    }
    
    public var handleRequest: (HTTPRequest, String) -> HTTPResponse
}

public typealias Routing = [RoutingComponent]
