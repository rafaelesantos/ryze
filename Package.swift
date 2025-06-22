// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Ryze",
    defaultLocalization: "pt",
    platforms: [
        .iOS(.v26),
        .macCatalyst(.v26),
        .macOS(.v26),
        .tvOS(.v26),
        .watchOS(.v26),
        .visionOS(.v26)
    ],
    products: [
        .library(name: "Ryze", type: .static, targets: ["RyzeFoundation", "RyzeDependency", "RyzeNetwork", "RyzeArchitecture", "RyzeUI"]),
        .library(name: "RyzeFoundation", type: .static, targets: ["RyzeFoundation"]),
        .library(name: "RyzeDependency", type: .static, targets: ["RyzeFoundation", "RyzeDependency"]),
        .library(name: "RyzeNetwork", type: .static, targets: ["RyzeFoundation", "RyzeNetwork", "RyzeDependency"]),
        .library(name: "RyzeArchitecture", type: .static, targets: ["RyzeFoundation", "RyzeArchitecture"]),
        .library(name: "RyzeUI", type: .static, targets: ["RyzeFoundation", "RyzeUI"])
    ],
    targets: [
        .target(name: "RyzeFoundation"),
        .target(name: "RyzeDependency", dependencies: ["RyzeFoundation"]),
        .target(name: "RyzeNetwork", dependencies: ["RyzeFoundation", "RyzeDependency"]),
        .target(name: "RyzeArchitecture", dependencies: ["RyzeFoundation"]),
        .target(name: "RyzeUI", dependencies: ["RyzeFoundation"]),
        .executableTarget(name: "RyzePreview", dependencies: ["RyzeFoundation", "RyzeUI"])
    ]
)
