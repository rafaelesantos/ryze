// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Ryze",
    defaultLocalization: "pt",
    platforms: [
        .iOS(.v18),
        .macCatalyst(.v18),
        .macOS(.v15),
        .tvOS(.v18),
        .watchOS(.v11),
        .visionOS(.v2)
    ],
    products: [
        .library(name: "Ryze", targets: ["RyzeFoundation", "RyzeDependency", "RyzeNetwork", "RyzeArchitecture", "RyzeUI"]),
        .library(name: "RyzeFoundation", type: .static, targets: ["RyzeFoundation"]),
        .library(name: "RyzeDependency", type: .static, targets: ["RyzeFoundation", "RyzeDependency"]),
        .library(name: "RyzeNetwork", type: .static, targets: ["RyzeFoundation", "RyzeNetwork"]),
        .library(name: "RyzeArchitecture", type: .static, targets: ["RyzeFoundation", "RyzeArchitecture"]),
        .library(name: "RyzeUI", type: .static, targets: ["RyzeFoundation", "RyzeUI"])
    ],
    targets: [
        .target(name: "RyzeFoundation"),
        .target(name: "RyzeDependency", dependencies: ["RyzeFoundation"]),
        .target(name: "RyzeNetwork", dependencies: ["RyzeFoundation"]),
        .target(name: "RyzeArchitecture", dependencies: ["RyzeFoundation"]),
        .target(name: "RyzeUI", dependencies: ["RyzeFoundation"])
    ]
)
