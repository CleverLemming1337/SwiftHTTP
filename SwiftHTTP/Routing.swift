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
}

// Endpoint für den Routing-Mechanismus
public struct Endpoint: RoutingComponent {
    public let path: String
    let handler: (HTTPRequest) -> HTTPResponse
    
    init(_ path: String = "", _ handler: @escaping (HTTPRequest) -> HTTPResponse) {
        self.path = path
        self.handler = handler
    }
}

// Route für die Gruppierung von Endpoints
public struct Route: RoutingComponent {
    public let path: String
    public let endpoints: [RoutingComponent]
    
    init(_ path: String, @RoutingBuilder builder: () -> [RoutingComponent]) {
        self.path = path
        self.endpoints = builder()
    }
}

public typealias Routing = [RoutingComponent]
