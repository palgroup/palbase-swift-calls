// swift-tools-version:6.0
// Palbase's iOS calls SDK 0.16.3 — voice and video calls (CallKit, PushKit, LiveKit's client inside), apart from
// palbase-swift: an app that makes no calls resolves none of it. Built from palbase-swift-src by scripts/xcframework.sh;
// do not edit here.
import PackageDescription

let package = Package(
    name: "PalbaseCalls",
    platforms: [.iOS(.v18)],
    products: [
        .library(name: "PalbaseCalls", targets: ["PalbaseCalls", "PalbaseCallsLinks"]),
        // The app's Broadcast Upload Extension links this alone, never the app: LiveKit is inside PalbaseCalls.
        .library(name: "PalbaseCallsBroadcast", targets: ["PalbaseCallsBroadcast"]),
    ],
    dependencies: [
        .package(url: "https://github.com/palgroup/palbase-swift", exact: "0.16.3"),
        .package(url: "https://github.com/livekit/webrtc-xcframework.git", exact: "150.7871.04"),
        .package(url: "https://github.com/livekit/livekit-ffi-xcframework.git", exact: "0.13.1"),
        .package(url: "https://github.com/livekit/client-sdk-swift.git", exact: "2.19.0"),
    ],
    targets: [
        .binaryTarget(name: "PalbaseCalls", url: "https://palgroup.github.io/palbase-swift-binaries/0.16.3/PalbaseCalls.xcframework.zip", checksum: "f1d3fe9bc5a74aaa347a2cee087cc09614cf887ae02eab6ce8f39e77589c4608"),
        .target(name: "PalbaseCallsBroadcast", dependencies: [.product(name: "LiveKit", package: "client-sdk-swift")]),
        .target(name: "PalbaseCallsLinks", dependencies: [.product(name: "Palbase", package: "palbase-swift"), .product(name: "PalbaseNotify", package: "palbase-swift"),
                                                   .product(name: "LiveKitWebRTC", package: "webrtc-xcframework"), .product(name: "LiveKitFFI", package: "livekit-ffi-xcframework")]),
    ]
)
