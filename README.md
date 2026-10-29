# Palbase Calls for iOS

Voice and video calls between the people of an app built on [Palbase](https://palbase.studio): ringing by CallKit and
PushKit (the lock screen and a closed app too), a direct call's media between its two devices over WebRTC, a group's —
or a direct call a third person joins — through the project's media server. Apart from
[palbase-swift](https://github.com/palgroup/palbase-swift), so an app that makes no calls resolves none of it.
Distributed as binary XCFrameworks.

## Install

Swift Package Manager — in Xcode, *File → Add Package Dependencies…* with `https://github.com/palgroup/palbase-swift-calls`,
or in a `Package.swift`, at the same version as `palbase-swift`:

```swift
.package(url: "https://github.com/palgroup/palbase-swift-calls", exact: "0.14.1")
```

Link `PalbaseCalls` (the calls, headless) and, for the ready screens, `PalbaseCallsUI`. They bring Palbase's core and
notify of the same version, LiveKit's WebRTC ([livekit/webrtc-xcframework](https://github.com/livekit/webrtc-xcframework),
the one `PalbaseVoice` takes too) and LiveKit's FFI library; LiveKit's client SDK (Apache-2.0) is inside `PalbaseCalls`
— an app that takes the calls does not take LiveKit's own package beside them.

The app's Info.plist says why it asks for the microphone (`NSMicrophoneUsageDescription`) and the camera
(`NSCameraUsageDescription`), its background modes include `voip` and `audio`, and it has the Push Notifications
capability.

```swift
import PalbaseCalls
import PalbaseCallsUI

// At launch, before application(_:didFinishLaunchingWithOptions:) returns:
pb.calls.configure(.init(iconTemplateImageName: "CallIcon"))

let call = try await pb.calls.call(otherUserId, video: true)   // PBCall, @Observable
call.setMuted(true)
await call.hangUp()

// The calls' screens over the app: a call ringing in it, and the call the person is in.
ContentView().callScreens(pb.calls)
```

Requires iOS 18 and Xcode 16.3 or newer.

## Licence

The Palbase SDK License — see `LICENSE`: free to use in your apps; the SDK is distributed compiled, and its source is
not part of it. WebRTC is LiveKit's build and LiveKit's client SDK is LiveKit's, each under its own licence.
