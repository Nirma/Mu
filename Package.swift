// swift-tools-version: 5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Mu",
    platforms: [.iOS(.v15),.macOS(.v12),.watchOS(.v8)],
    products: [
        .library(
            name: "Mu",
            targets: ["Mu"]),
    ],
    dependencies: [ ],
    targets: [
        .target(
            name: "Mu",
            dependencies: []),
        .testTarget(
            name: "MuTests",
            dependencies: ["Mu"]),
    ]
)
