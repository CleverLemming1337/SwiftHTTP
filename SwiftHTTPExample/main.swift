import SwiftHTTP
import SwiftHTML

struct SampleServer: Server {
    let port = 8080
    
    var routing: Routing {
        Endpoint { request in
            print("Request to /")
            return HTTPResponse("Hello, world!")
        }
        Route("people") {
            Endpoint { request in
                print("Request to /people/")
                return HTTPResponse("Listing people")
            }
            Endpoint("new") { request in
                print("Request to /people/new/")
                return HTTPResponse(CreatePersonPage())
            }
            Endpoint(method: .post, "new") { request in
                return HTTPResponse("You created a person with: \(request.body)")
            }
        }
        Route(method: .get, "tests") {
            Endpoint(method: .post) { request in // should never be executed
                HTTPResponse(status: .httpInternalServerError, "Internal server error.")
            }
        }
    }
}

struct CreatePersonPage: HTMLPage {
    let name = "CreatePersonPage"
    
    var body: HTML {
        Heading("Create person")
        Form(action: "/people/new") {
            Input(name: "name", placeholder: "Enter the new person's name")
            LineBreak()
            Input(.submit, value: "Submit")
        }
    }
}

do {
    try SampleServer().start()
}
catch {
    print("Error: \(error.localizedDescription)")
}
