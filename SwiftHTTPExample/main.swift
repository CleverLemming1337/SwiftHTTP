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
                guard request.headers["Content-Type"] == "application/x-www-form-urlencoded" else {
                    return HTTPResponse(status: .httpNotAcceptable, headers: ["Accept": "application/x-www-form-urlencoded"], "Not acceptable.")
                }
                guard let formData = request.formData else { return HTTPResponse(status: .httpUnprocessableEntity, "Invalid form data") }
                let name = formData["name", default: "unknown"]
                let age = formData["age", default: "unknown"]
                
                return HTTPResponse("You created a person with name: \(name) and age: \(age != "" ? age : "empty")")
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
            Input(name: "name", placeholder: "Enter the new person's name", required: true)
            LineBreak()
            Input(.number, name: "age", placeholder: "Age")
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
