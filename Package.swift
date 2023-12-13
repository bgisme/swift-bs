// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "swift-bs",
    platforms: [
        .macOS(.v10_15)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "SwiftBs", targets: ["SwiftBs"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
//        .package(url: "https://github.com/binarybirds/swift-html", from: "1.6.0"),
        .package(url: "https://github.com/bgisme/swift-html.git", from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "SwiftBs",
            dependencies: [
                .product(name: "SwiftHtml", package: "swift-html"),
                .product(name: "SwiftSvg", package: "swift-html"),
            ]),
        .testTarget(
            name: "SwiftBsTests", dependencies: [
                "SwiftBs"
            ]),
    ]
)
