```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: Handle multiple URLs from Open With in SwiftUI on Mac (by Steve M)

A: As described (see below) it registers handler for external events, but uses only first to create new scene (maybe due to limitations, maybe bug, maybe intentionally, who knows...)

![LQGp8](https://user-images.githubusercontent.com/62171579/174019966-fe5c23ec-72cc-4bb2-a985-b50f3927bc7c.png)

so if we have `.onOpenURL` that registered handler captures one URL and create new scene for it, others are remains unhandled and received in `AppDelegate` (see below). If we remove `.onOpenURL` completely, all opened URLs from Finder transferred to AppDelegate.

Tested with Xcode 13.4 / macOS 12.4

in App

    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        // needed because WindowGroup scene seems have default
        // handler for external events, so opens new scene even
        // if no onOpenURL or userActivity callbacks are present
        .handlesExternalEvents(matching: [])   // << here !!
    }

and delegate

```
class AppDelegate: NSObject, NSApplicationDelegate {
	func application(_ application: NSApplication, open urls: [URL]) {
		print("Unhandled: \(urls)")    // << here !!
	}
}
```

[Compelete test module is here](https://github.com/Asperi-Demo/4SwiftUI/blob/master/PlayOn_macOS/PlayOn_macOS/PlayOn_macOSApp.swift)

