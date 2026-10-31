# Palbase Calls for iOS

Voice and video calls between the people of an app built on [Palbase](https://palbase.studio): ringing by CallKit and
PushKit (the lock screen and a closed app too), every call's media — one to one or in a group — through Palbase's media
server (LiveKit); a direct call a third person joins goes on in the same room; meetings at a place the app names (a
channel, a conversation) that its people find and join; screen sharing. Palbase gives the calls' state and actions —
the app draws its own call screens from them. Apart from
[palbase-swift](https://github.com/palgroup/palbase-swift), so an app that makes no calls resolves none of it.
Distributed as binary XCFrameworks.

## Install

Swift Package Manager — in Xcode, *File → Add Package Dependencies…* with `https://github.com/palgroup/palbase-swift-calls`,
or in a `Package.swift`, at the same version as `palbase-swift`:

```swift
.package(url: "https://github.com/palgroup/palbase-swift-calls", exact: "0.16.0")
```

Link `PalbaseCalls` to the app. It brings Palbase's core and
notify of the same version, LiveKit's WebRTC ([livekit/webrtc-xcframework](https://github.com/livekit/webrtc-xcframework),
the one `PalbaseVoice` takes too) and LiveKit's FFI library; LiveKit's client SDK (Apache-2.0) is inside `PalbaseCalls`
— an app that takes the calls does not take LiveKit's own package beside them. Only a broadcast extension (a process
of its own) links it, through `PalbaseCallsBroadcast`, at the version inside `PalbaseCalls`.

The app's Info.plist says why it asks for the microphone (`NSMicrophoneUsageDescription`) and the camera
(`NSCameraUsageDescription`), its background modes include `voip` and `audio`, and it has the Push Notifications
capability.

```swift
import PalbaseCalls

// At launch, before application(_:didFinishLaunchingWithOptions:) returns:
pb.calls.configure(.init(iconTemplateImageName: "CallIcon"))

let call = try await pb.calls.call(otherUserId, video: true)   // PBCall, @Observable
call.setMuted(true)
try await call.setScreenShare(true)                            // the app's own screen
await call.hangUp()

// The app's own screens, from the calls' state: pb.calls.ringing (accept(), decline()) and pb.calls.current
// (remoteVideos, remoteScreens, localVideo drawn by CallVideoView; the controls).

// A meeting at a place: its call followed while the view shows, joined or started.
let place = pb.calls.place("channel:42")
// .task { try? await place.watch() }
if place.call != nil { try await place.join() } else { try await place.start(video: true) }
```

To share the whole screen (other apps too, the app in the background), configure `screenShare: .broadcastExtension`
and add a Broadcast Upload Extension to the app: its bundle identifier the app's with `.broadcast` after it, the app
group `group.<the app's bundle identifier>` in both targets' entitlements, `PalbaseCallsBroadcast` linked to the
extension alone (never the app), and its SampleHandler:

```swift
import PalbaseCallsBroadcast

final class SampleHandler: PalbaseBroadcastHandler, @unchecked Sendable {}
```

Requires iOS 18 and Xcode 16.3 or newer.

## Licence

The Palbase SDK License — see `LICENSE`: free to use in your apps; the SDK is distributed compiled, and its source is
not part of it (`PalbaseCallsBroadcast`, a subclass of LiveKit's with nothing in it, is the one source file). WebRTC is LiveKit's build and LiveKit's client SDK is LiveKit's, each under its own licence.
