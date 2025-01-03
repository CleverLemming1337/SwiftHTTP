//
//  Server.swift
//  SwiftHTTP
//
//  Created by CleverLemming on 03.01.25.
//

import Foundation
import Network

public func startServer() throws {
    let server = HTTPServer(port: 8080)
    try server.start()
    print("Server läuft auf Port 8080")
    
    RunLoop.main.run()
}

public protocol Server {
    var port: Int { get }
    @RoutingBuilder var routing: Routing { get }
}

public extension Server {
    func start() throws {
        let server = HTTPServer(port: UInt16(port))
        try server.start()
        
        RunLoop.current.run()
    }
}
