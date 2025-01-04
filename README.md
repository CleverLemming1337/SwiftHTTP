# SwiftHTTP
SwiftHTTP is a simple and easy-to-use framework for creating HTTP servers with or without databases as well as websites.

## SwiftHTML
With SwiftHTML you can build HTML websites with Swift's declarative result builder Syntax.
Here's an example:

```swift
struct SamplePage: HTMLPage {
    let name = "TestPage"
    
    var body: HTML {
        Heading("This is SwiftHTML")
        Link(to: "tutorial", "Tutorial")
        Image(from: "https://...", alt: "This is an example image")
        Paragraph("SwiftHTML is a Swift framework that lets you build HTML sites with Swift's declarative result builder syntax.\nHere an example:")
        Code("""
            some code here...
        """)
    }
}
```

## SwiftHTTP
SwiftHTTP lets you build HTTP server routings easily. Additionally, you can combine it with SwiftHTML to let your server return dynamically generated HTML websites.

```swift
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
                return HTTPResponse("Creating new person")
            }
        }
    }
}
```
