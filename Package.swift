// swift-tools-version:6.0
// Palbase's iOS calls SDK 0.20.0 — voice and video calls (CallKit, PushKit, LiveKit's client inside), apart from
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
        .package(url: "https://github.com/palgroup/palbase-swift", exact: "0.20.0"),
        .package(url: "https://github.com/livekit/webrtc-xcframework.git", exact: "150.7871.04"),
        .package(url: "https://github.com/livekit/client-sdk-swift.git", exact: "2.19.0"),
    ],
    targets: [
        .binaryTarget(name: "PalbaseCalls", url: "https://palgroup.github.io/palbase-swift-binaries/0.20.0/PalbaseCalls.xcframework.zip", checksum: "b5201d9ed2060ec35b7ba21ee372039c603cd6765d147d814bf0cc50f87f96fa"),
        .binaryTarget(name: "PalbaseCallsFFI", url: "https://palgroup.github.io/palbase-swift-binaries/0.20.0/PalbaseCallsFFI.xcframework.zip", checksum: "813a99852cbec66c6f290fe776c66a7c54dac709bc50d1a696fd745062d55263"),
        .target(name: "PalbaseCallsBroadcast", dependencies: [.product(name: "LiveKit", package: "client-sdk-swift")]),
        .target(name: "PalbaseCallsLinks", dependencies: [.product(name: "Palbase", package: "palbase-swift"), .product(name: "PalbaseNotify", package: "palbase-swift"),
                                                   .product(name: "LiveKitWebRTC", package: "webrtc-xcframework"), "PalbaseCallsFFI"]),
    ]
)
