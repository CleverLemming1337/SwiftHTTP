//
//  SwiftHTTPTests.swift
//  SwiftHTTPTests
//
//  Created by CleverLemming on 02.01.25.
//

import Testing
@testable import SwiftHTTP

struct SwiftHTTPTests {

    @Test func example() async throws {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
        
    }
    
    @Test("Route listing")
    func listRoutes() async throws {
        let server = TestServer()
        
        listRouting(server.routing)
    }
    
    @Test("Route handling")
    func handleRoutes() async throws {
        let server = TestServer()
        try server.start()
        print(server.handleRequest(HTTPRequest("/people", headers: [:], body: "Hello"), "/people"))
    }

}

struct TestServer: Server {
    let port = 8080
    
    var routing: Routing {
        Endpoint { request, _ in
            print("Request to /")
            return HTTPResponse("Hello, world!")
        }
        Route("people") {
            Endpoint { request, _ in
                print("Request to /people/")
                return HTTPResponse("Listing people")
            }
            Endpoint("new") { request, _ in
                print("Request to /people/new/")
                return HTTPResponse("Creating new person")
            }
        }
    }
}

func listRouting(_ routing: Routing, from startRoute: String = "/") {
    for routingComponent in routing {
        if let endpoint = routingComponent as? Endpoint {
            print("\(startRoute.trimmingCharacters(in: .slashes))/\(endpoint.path.trimmingCharacters(in: .slashes))")
        }
        else if let route = routingComponent as? Route {
            listRouting(route.routing, from: "\(startRoute.trimmingCharacters(in: .slashes))/\(route.path)")
        }
    }
}

extension CharacterSet {
    static let slashes = CharacterSet(charactersIn: "/")
}
