// swift-tools-version:6.0
// Palbase's iOS calls SDK 0.14.1 — voice and video calls (CallKit, PushKit, WebRTC, LiveKit's client inside), apart from
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
        .package(url: "https://github.com/palgroup/palbase-swift", exact: "0.14.1"),
        .package(url: "https://github.com/livekit/webrtc-xcframework.git", exact: "150.7871.04"),
        .package(url: "https://github.com/livekit/livekit-ffi-xcframework.git", exact: "0.13.1"),
    ],
    targets: [
        .binaryTarget(name: "PalbaseCalls", url: "https://palgroup.github.io/palbase-swift-binaries/0.14.1/PalbaseCalls.xcframework.zip", checksum: "c7ad957c033bf21fcd316695739dcecd5c811cc7e9f94c9a2a30824aee5d2e81"),
        .binaryTarget(name: "PalbaseCallsUI", url: "https://palgroup.github.io/palbase-swift-binaries/0.14.1/PalbaseCallsUI.xcframework.zip", checksum: "8bf01401ca8d243cd5212e19a0afc8c6addb9755ba89fff89281303eabec480d"),
        .target(name: "PalbaseCallsLinks", dependencies: [.product(name: "Palbase", package: "palbase-swift"), .product(name: "PalbaseNotify", package: "palbase-swift"),
                                                   .product(name: "LiveKitWebRTC", package: "webrtc-xcframework"), .product(name: "LiveKitFFI", package: "livekit-ffi-xcframework")]),
    ]
)
