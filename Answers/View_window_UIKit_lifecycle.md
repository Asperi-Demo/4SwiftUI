```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
       on StackOverflow site. Thanks, Asperi.
```

Q: How to access own window within SwiftUI view?

A: 
### SwiftUI Lift-Cycle (SwiftUI 2+)

Here is a solution (tested with Xcode 13.4), to be brief only for iOS

1) We need application delegate to create scene configuration with our scene delegate class

```
@main
struct PlayOn_iOSApp: App {
	@UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    // ...
}

class AppDelegate: NSObject, UIApplicationDelegate {


	func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
		let configuration = UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)
		if connectingSceneSession.role == .windowApplication {
			configuration.delegateClass = SceneDelegate.self
		}
		return configuration
	}
}
```

2) Declare our `SceneDelegate` and confirm it to both (!!!+) `UIWindowSceneDelegate` and `ObservableObject`

```
class SceneDelegate: NSObject, ObservableObject, UIWindowSceneDelegate {
	var window: UIWindow?   // << contract of `UIWindowSceneDelegate`

	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		guard let windowScene = scene as? UIWindowScene else { return }
		self.window = windowScene.keyWindow   // << store !!!
	}
}

```

3) Now we can use our delegate anywhere (!!!) in view hierarchy as `EnvironmentObject`, because (bonus of confirming to `ObservableObject`) SwiftUI automatically injects it into `ContentView`

```
	@EnvironmentObject var sceneDelegate: SceneDelegate
	
	var body: some View {
              Text("STOP russia")
			.onAppear {
				if let myWindow = sceneDelegate.window {
					print(">> window: \(myWindow.description)")
				}
			}
	}
```

![Screenshot 2022-05-30 at 19 56 59](https://user-images.githubusercontent.com/62171579/171037991-2af6678f-3506-4ce3-bca8-a43783f90885.png)

[Complete code in project is here](https://github.com/Asperi-Demo/4SwiftUI/blob/master/PlayOn_iOS/PlayOn_iOS/Findings/TestWindowFromScene.swift)

### UIKit Life-Cycle

Here is the result of my experiments that looks appropriate for me, so one might find it helpful as well. Tested with Xcode 11.2 / iOS 13.2 / macOS 15.0

The idea is to use native SwiftUI Environment concept, because once injected environment value becomes available for entire view hierarchy automatically. So

1) Define Environment key. Note, it needs to remember to avoid reference cycling on kept window

```
  struct HostingWindowKey: EnvironmentKey {
  
  #if canImport(UIKit)
    typealias WrappedValue = UIWindow
  #elseif canImport(AppKit)
    typealias WrappedValue = NSWindow
  #else
    #error("Unsupported platform")
  #endif
  
    typealias Value = () -> WrappedValue? // needed for weak link
    static let defaultValue: Self.Value = { nil }
  }
  
  extension EnvironmentValues {
    var hostingWindow: HostingWindowKey.Value {
      get {
        return self[HostingWindowKey.self]
      }
      set {
        self[HostingWindowKey.self] = newValue
      }
    }
  }
```

2) Inject hosting window in root ContentView in place of window creation (either in AppDelegate or in SceneDelegate, just once

```
  // window created here
  
  let contentView = ContentView()
             .environment(\.hostingWindow, { [weak window] in
                return window })
  
  #if canImport(UIKit)
    	window.rootViewController = UIHostingController(rootView: contentView)
  #elseif canImport(AppKit)
     	window.contentView = NSHostingView(rootView: contentView)
  #else
    #error("Unsupported platform")
  #endif
```

3) use only where needed, just by declaring environment variable

```
  struct ContentView: View {
    @Environment(\.hostingWindow) var hostingWindow
    
    var body: some View {
      VStack {
        Button("Action") {
          // self.hostingWindow()?.close() // macOS
          // self.hostingWindow()?.makeFirstResponder(nil) // macOS
          // self.hostingWindow()?.resignFirstResponder() // iOS
          // self.hostingWindow()?.rootViewController?.present(UIKitController(), animating: true)
        }
      }
    }
  }
```
