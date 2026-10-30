// swift-tools-version:6.0
// Palbase's iOS calls SDK 0.15.0 — voice and video calls (CallKit, PushKit, LiveKit's client inside), apart from
// palbase-swift: an app that makes no calls resolves none of it. Built from palbase-swift-src by scripts/xcframework.sh;
// do not edit here.
import PackageDescription

let package = Package(
    name: "PalbaseCalls",
    platforms: [.iOS(.v18)],
    products: [
        .library(name: "PalbaseCalls", targets: ["PalbaseCalls", "PalbaseCallsLinks"]),
        .library(name: "PalbaseCallsUI", targets: ["PalbaseCallsUI", "PalbaseCalls", "PalbaseCallsLinks"]),
    ],
    dependencies: [
        .package(url: "https://github.com/palgroup/palbase-swift", exact: "0.15.0"),
        .package(url: "https://github.com/livekit/webrtc-xcframework.git", exact: "150.7871.04"),
        .package(url: "https://github.com/livekit/livekit-ffi-xcframework.git", exact: "0.13.1"),
    ],
    targets: [
        .binaryTarget(name: "PalbaseCalls", url: "https://palgroup.github.io/palbase-swift-binaries/0.15.0/PalbaseCalls.xcframework.zip", checksum: "8d6ef9ad37eb5924b984e2ea0f1a177ff3cd85c66bf5505d11991265de88001a"),
        .binaryTarget(name: "PalbaseCallsUI", url: "https://palgroup.github.io/palbase-swift-binaries/0.15.0/PalbaseCallsUI.xcframework.zip", checksum: "9a85a18e603205d0131ffcf32bdeb7bebc9d78c9a066ae2ac386d6adf54edd2f"),
        .target(name: "PalbaseCallsLinks", dependencies: [.product(name: "Palbase", package: "palbase-swift"), .product(name: "PalbaseNotify", package: "palbase-swift"),
                                                   .product(name: "LiveKitWebRTC", package: "webrtc-xcframework"), .product(name: "LiveKitFFI", package: "livekit-ffi-xcframework")]),
    ]
)
