//
//  SwiftHTTPTests.swift
//  SwiftHTTPTests
//
//  Created by CleverLemming on 02.01.25.
//

import Testing
@testable import SwiftHTTP

struct SwiftHTTPTests {

    @Test func example()  throws {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.

        func initServer(port: UInt16) {
            let server = Server(port: port)
            try! server.start()
        }

            
              initServer(port: 8080)
        RunLoop.current.run()
    }

}
