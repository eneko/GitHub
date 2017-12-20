// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "GitHub",
    products: [
        .library(name: "GitHub", targets: ["GitHub"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(name: "GitHub", dependencies: []),
        .testTarget(name: "GitHubTests", dependencies: ["GitHub"]),
    ]
)
