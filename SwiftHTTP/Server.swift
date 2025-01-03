//
//  Server.swift
//  SwiftHTTP
//
//  Created by Leonard Fekete on 03.01.25.
//

import Foundation
import Network

public func startServer() throws {
    let server = Server(port: 8080)
    try server.start()
    print("Server läuft auf Port 8080")
    
    RunLoop.main.run()
}
