//
//  Server.swift
//  SwiftHTTP
//
//  Created by CleverLemming on 03.01.25.
//

import Foundation
import Network

public func startServer() throws {
    let server = HTTPServer(port: 8080, handleRequest: { _, _ in HTTPResponse("Hello, world!") })
    try server.start()
    
    RunLoop.main.run()
}

public protocol Server {
    var port: Int { get }
    @RoutingBuilder var routing: Routing { get }
}

public extension Server {
    func start() throws {
        let server = HTTPServer(port: UInt16(port), handleRequest: handleRequest)
        try server.start()
        RunLoop.current.run()
    }
    
    func handleRequest(_ request: HTTPRequest, _ path: String) -> HTTPResponse {
        var pathComponents = request.path.trimmingCharacters(in: CharacterSet(charactersIn: "/")).split(separator: "/")
        if pathComponents.count == 0 {
            pathComponents = [""]
        }
        
        let matchingRoutingComponents = routing.filter { $0.path == pathComponents[0] }
        if matchingRoutingComponents.isEmpty { // No routes found
            return HTTPResponse(status: .httpNotFound, "Not found")
        }
        
        for routingComponent in matchingRoutingComponents {
            if routingComponent.method == nil || routingComponent.method! == request.method {
                return routingComponent.handleRequest(request, path)
            }
        }
        
        return HTTPResponse(status: .httpMethodNotAllowed, "Method not allowed.")
    }
}
