// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "SwiftHTTP",
    platforms: [
        .macOS(.v13)
    ],
    products: [
        // Library for SwiftHTTP
        .library(
            name: "SwiftHTTP",
            targets: ["SwiftHTTP"]
        ),
        // Library for SwiftHTML
        .library(
            name: "SwiftHTML",
            targets: ["SwiftHTML"]
        ),
        // Executable for CLI example
        .executable(
            name: "SwiftHTTPExample",
            targets: ["SwiftHTTPExample"]
        ),
    ],
    dependencies: [
        // Dependencies can be added here, if needed.
        // Example:
        // .package(url: "https://github.com/Some/Package.git", from: "1.0.0"),
    ],
    targets: [
        // Framework: SwiftHTTP
        .target(
            name: "SwiftHTTP",
	    dependencies: ["SwiftHTML"],
            path: "SwiftHTTP"
        ),
        // Tests for SwiftHTTP
        .testTarget(
            name: "SwiftHTTPTests",
            dependencies: ["SwiftHTTP"],
            path: "SwiftHTTPTests"
        ),
        // Framework: SwiftHTML
        .target(
            name: "SwiftHTML",
            path: "SwiftHTML",
            resources: [
                // Add any resource files here if needed
            ]
        ),
        // Tests for SwiftHTML
        .testTarget(
            name: "SwiftHTMLTests",
            dependencies: ["SwiftHTML"],
            path: "SwiftHTMLTests"
        ),
        // CLI Example for SwiftHTTP
        .executableTarget(
            name: "SwiftHTTPExample",
            dependencies: ["SwiftHTTP"],
            path: "SwiftHTTPExample"
        )
    ]
)
