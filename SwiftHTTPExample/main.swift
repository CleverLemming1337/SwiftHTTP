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
        }
    }
}

struct CreatePersonPage: HTMLPage {
    let name = "CreatePersonPage"
    
    var body: HTML {
        Heading("Create person")
        Form(action: "/handleform") {
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
