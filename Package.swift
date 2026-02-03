// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Ryze",
    defaultLocalization: "pt",
    platforms: [
        .iOS(.v26),
        .macOS(.v26),
        .macCatalyst(.v26),
        .tvOS(.v26),
        .driverKit(.v25),
        .watchOS(.v26)
    ],
    products: [
        .library(
            name: "Ryze",
            type: .static,
            targets: [
                "RyzeFoundation",
                "RyzeNetwork",
                "RyzeArchitecture",
                "RyzeUI",
                "RyzeVideo",
                "RyzeIntelligence"
            ]
        )
    ],
    targets: [
        .target(name: "RyzeFoundation"),
        .target(
            name: "RyzeNetwork",
            dependencies: ["RyzeFoundation"],
            resources: [
                .process("Resource")
            ]
        ),
        .target(
            name: "RyzeArchitecture",
            dependencies: ["RyzeFoundation"]
        ),
        .target(
            name: "RyzeUI",
            dependencies: ["RyzeFoundation"],
            resources: [
                .copy("Resources/Symbols.json")
            ]
        ),
        .target(
            name: "RyzeVideo",
            dependencies: ["RyzeFoundation"]
        ),
        .target(
            name: "RyzeIntelligence",
            dependencies: ["RyzeFoundation"]
        ),
        .target(
            name: "RyzePreview",
            dependencies: [
                "RyzeFoundation",
                "RyzeNetwork",
                "RyzeArchitecture",
                "RyzeVideo",
                "RyzeIntelligence",
                "RyzeUI"
            ]
        )
    ]
)
