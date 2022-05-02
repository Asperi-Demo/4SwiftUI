```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: Manually set light/dark mode in SwiftUI and save users choice (by Ryan)

A: Here is possible approach (scratchy, you can find here on SO property wrapper for defaults and use it for better styling, but the idea to achieve your goal is the same)

Tested with Xcode 11.4 / iOS 13.4

```
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    private(set) static var shared: SceneDelegate?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        Self.shared = self

        let contentView = ContentView()

        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)

            // restore from defaults initial or previously stored style
            let style = UserDefaults.standard.integer(forKey: "LastStyle")
            window.overrideUserInterfaceStyle = (style == 0 ? .dark : UIUserInterfaceStyle(rawValue: style)!)

            window.rootViewController = UIHostingController(rootView: contentView)
            self.window = window
            window.makeKeyAndVisible()
        }
    }

   ...
}


struct ContentView: View {
    var body: some View {
         // manipulate with style directly in defaults
         Toggle(isOn: Binding<Bool>(
            get: { UserDefaults.standard.integer(forKey: "LastStyle") !=
                        UIUserInterfaceStyle.light.rawValue },
            set: {
                SceneDelegate.shared?.window!.overrideUserInterfaceStyle = $0 ? .dark : .light
                UserDefaults.standard.setValue($0 ? UIUserInterfaceStyle.dark.rawValue : UIUserInterfaceStyle.light.rawValue, forKey: "LastStyle")
            }
         )) {
             Text("is Dark")
        }
    }
}

```
