// swift-tools-version:6.0
// Palbase's calls SDK 0.22.0 — re-exports PalbaseCalls from palbase-swift (iOS and macOS) and provides
// PalbaseCallsBroadcast for iOS Broadcast Upload Extensions. Built from palbase-swift-src by
// scripts/xcframework.sh; do not edit here.
import PackageDescription

let package = Package(
    name: "PalbaseCalls",
    platforms: [.iOS(.v18), .macOS(.v15)],
    products: [
        .library(name: "PalbaseCalls", targets: ["PalbaseCallsLinks"]),
        // The app's iOS Broadcast Upload Extension links this alone, never the app: LiveKit is inside PalbaseCalls.
        .library(name: "PalbaseCallsBroadcast", targets: ["PalbaseCallsBroadcast"]),
    ],
    dependencies: [
        .package(url: "https://github.com/palgroup/palbase-swift", exact: "0.22.0"),
        .package(url: "https://github.com/livekit/client-sdk-swift.git", exact: "2.19.0"),
    ],
    targets: [
        .target(name: "PalbaseCallsBroadcast", dependencies: [.product(name: "LiveKit", package: "client-sdk-swift")]),
        .target(name: "PalbaseCallsLinks", dependencies: [.product(name: "PalbaseCalls", package: "palbase-swift")]),
    ]
)
