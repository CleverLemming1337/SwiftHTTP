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
    public let handleRequest: (HTTPRequest, String) -> HTTPResponse
    
    public init(_ path: String = "", _ handler: @escaping (HTTPRequest, String) -> HTTPResponse) {
        self.path = path
        self.handleRequest = handler
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
            print("Searching \(path) in \(self.path)")
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
