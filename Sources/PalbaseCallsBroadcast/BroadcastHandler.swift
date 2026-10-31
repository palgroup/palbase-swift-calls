#if os(iOS)
public import LiveKit

/// The app's Broadcast Upload Extension: the whole screen — other apps and the home screen too, the app in the
/// background — shared in a call, when the app configures the calls with `screenShare: .broadcastExtension`. The
/// extension is a subclass with nothing in it:
///
/// ```swift
/// import PalbaseCallsBroadcast
///
/// final class SampleHandler: PalbaseBroadcastHandler, @unchecked Sendable {}
/// ```
///
/// The extension target (Xcode's "Broadcast Upload Extension" template, its SampleHandler.swift replaced by the above)
/// links PalbaseCallsBroadcast alone — never the app, whose PalbaseCalls carries the other half — and its bundle
/// identifier is the app's with `.broadcast` after it. The app and the extension share an app group,
/// `group.<the app's bundle identifier>`, listed in both targets' entitlements: the extension hands the screen to the
/// app through it. Other names are set in the Info.plists: `RTCAppGroupIdentifier` (the app's and the extension's)
/// names the group, `RTCScreenSharingExtension` (the app's) the extension's bundle identifier.
///
/// It is LiveKit's sample handler (the media server's client the calls are built on), so the extension speaks the
/// version of it inside PalbaseCalls. Override `enableLogging` to read the extension's own lines in Console. LiveKit's
/// handler is `@unchecked Sendable` (ReplayKit calls it on threads of its own), and Swift 6 asks each subclass to say so
/// again.
@available(macCatalyst 13.1, *)
open class PalbaseBroadcastHandler: LKSampleHandler, @unchecked Sendable {}
#endif
