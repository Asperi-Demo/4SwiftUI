```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: How to open to a specific view using home quick actions (by user1909186)

A: Here is possible approach by steps (tested with Xcode 11.2 / iOS 13.2)

1) Add `AppSettings` class to store mode of views to be presented by shorcut

```
class AppSettings: ObservableObject {
    enum Mode {
        case one
        case two
    }
    @Published var mode: Mode? = nil
}
```

2) make `appSettings` scene delegate member to access it and in `ContentView` and in shortcut delegate and pass it in `ContentView` as environment object

```
    let appSettings = AppSettings()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    
        let contentView = ContentView().environmentObject(appSettings)
        // ...
```

3) activate corresponding mode in shortcut scene delegate

```
func windowScene(_ windowScene: UIWindowScene, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
    switch shortcutItem.type {
    case "QuickAction1":
        appSettings.mode = .one
        break
    case "QuickAction2":
        appSettings.mode = .two
        break
    default:
        break
    }
    // ...
}
```

4) Make `ContentView` present links conditionally based on selected shortcut mode

```
struct ContentView: View {
    @EnvironmentObject var appSettings: AppSettings

    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: OneView(),
                               tag: AppSettings.Mode.one,
                               selection: $appSettings.mode)
                    { Text("To One") }
                NavigationLink(destination: TwoView(),
                                tag: AppSettings.Mode.two,
                                selection: $appSettings.mode)
                    { Text("To Two") }
            }
        }
    }
}
```
