```
BOYCOTT on ᵣussia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
       on StackOverflow site. Thanks, Asperi.
```

Q: How to access own window within SwiftUI view?

A: Here is the result of my experiments that looks appropriate for me, so one might find it helpful as well. Tested with Xcode 11.2 / iOS 13.2 / macOS 15.0

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
