// swift-tools-version:6.0
// Palbase's iOS Broadcast Upload Extension handler 0.24.0 — for whole-screen sharing in PalbaseCalls.
// PalbaseCalls itself is in https://github.com/palgroup/palbase-swift. Built from palbase-swift-src by
// scripts/xcframework.sh; do not edit here.
import PackageDescription

let package = Package(
    name: "PalbaseCallsBroadcast",
    platforms: [.iOS(.v18)],
    products: [
        // The app's iOS Broadcast Upload Extension links this alone, never the app: LiveKit is inside PalbaseCalls.
        .library(name: "PalbaseCallsBroadcast", targets: ["PalbaseCallsBroadcast"]),
    ],
    dependencies: [
        .package(url: "https://github.com/livekit/client-sdk-swift.git", exact: "2.19.0"),
    ],
    targets: [
        .target(name: "PalbaseCallsBroadcast", dependencies: [.product(name: "LiveKit", package: "client-sdk-swift")]),
    ]
)
