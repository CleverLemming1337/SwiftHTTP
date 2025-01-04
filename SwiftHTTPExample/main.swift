import SwiftHTTP

struct SampleServer: Server {
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
do {
    try SampleServer().start()
}
catch {
    print("Error: \(error.localizedDescription)")
}
