// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "SwiftHTTP",
    platforms: [
        .macOS(.v10_14)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .executable(
            name: "SwiftHTTP",
            targets: ["SwiftHTTPExample", "SwiftHTTP"]),
        .library(
            name: "SwiftHTTP",
            targets: ["SwiftHTTP"]
        ),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .executableTarget(
            name: "SwiftHTTPExample",
            dependencies: ["SwiftHTTP"],
            path: "SwiftHTTPExample"
           
        ),
        .target(
            name: "SwiftHTTP",
            path: "SwiftHTTP"
        )

    ]
)
