// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Ryze",
    defaultLocalization: "pt",
    platforms: [
        .iOS(.v18),
        .macOS(.v15),
    ],
    products: [
        .library(name: "Ryze", type: .static, targets: ["RyzeFoundation", "RyzeNetwork", "RyzeArchitecture", "RyzeUI"])
    ],
    targets: [
        .target(name: "RyzeFoundation"),
        .target(name: "RyzeNetwork", dependencies: ["RyzeFoundation"]),
        .target(name: "RyzeArchitecture", dependencies: ["RyzeFoundation"]),
        .target(name: "RyzeUI", dependencies: ["RyzeFoundation"]),
        .executableTarget(name: "RyzePreview", dependencies: ["RyzeFoundation", "RyzeUI"])
    ]
)
