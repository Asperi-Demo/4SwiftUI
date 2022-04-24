```
BOYCOTT on ᵣussia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: Accessing AppState in AppDelegate with SwiftUI's new iOS 14 life cycle (by Mister22)

A: A possible approach is to use shared instance for `AppState`. As by intention is app-wide state, so 
it is the one, so it can be used static shared instance (it can be done even complete sigleton by making
init private). So as it is done as shared then it is available anywhere in app, like `NSApp` or `UIApplication.shared`.

```
class AppState: ObservableObject {
    static let shared = AppState()    // << here !!

    // Singe source of truth...
    @Published var user = User()
}
```

so you can use it everywhere

```
struct MyApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject var appState = AppState.shared

    // ... other code
}
```

and

```
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // ...and access appState here

        AppState.shared.user = ...
    }
```
