// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "VoveSDK",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "VoveSDK",
            targets: ["VoveSDK", "FaceTecSDK"])
    ],
    targets: [
        .binaryTarget(
            name: "VoveSDK",
            path: "VoveSDK.xcframework"),
        .binaryTarget(
            name: "FaceTecSDK",
            path: "FaceTecSDK.xcframework")
    ]
)