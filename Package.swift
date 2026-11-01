// swift-tools-version:6.0
// Palbase's iOS calls SDK 0.16.4 — voice and video calls (CallKit, PushKit, LiveKit's client inside), apart from
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
        .package(url: "https://github.com/palgroup/palbase-swift", exact: "0.16.4"),
        .package(url: "https://github.com/livekit/webrtc-xcframework.git", exact: "150.7871.04"),
        .package(url: "https://github.com/livekit/client-sdk-swift.git", exact: "2.19.0"),
    ],
    targets: [
        .binaryTarget(name: "PalbaseCalls", url: "https://palgroup.github.io/palbase-swift-binaries/0.16.4/PalbaseCalls.xcframework.zip", checksum: "f9142abe08643cbaf3c3499d9ef36c91247602e99e4804f58241050c62879d19"),
        .binaryTarget(name: "PalbaseCallsFFI", url: "https://palgroup.github.io/palbase-swift-binaries/0.16.4/PalbaseCallsFFI.xcframework.zip", checksum: "712149d001109211f3c35ac87b17a8182a0cf4f7a19cbaf53f020e62d932bcf3"),
        .target(name: "PalbaseCallsBroadcast", dependencies: [.product(name: "LiveKit", package: "client-sdk-swift")]),
        .target(name: "PalbaseCallsLinks", dependencies: [.product(name: "Palbase", package: "palbase-swift"), .product(name: "PalbaseNotify", package: "palbase-swift"),
                                                   .product(name: "LiveKitWebRTC", package: "webrtc-xcframework"), "PalbaseCallsFFI"]),
    ]
)
