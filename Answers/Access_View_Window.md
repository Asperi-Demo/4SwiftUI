```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: How to access NSWindow from @main App using only SwiftUI? (by Amadeu Cavalcante Filho)

A: > Basically, I'm trying to do something like:
> 
> `LoginView(store: AuthStore(window: window))`

Here is a demo of possible approach, because there is not native so far - create a
representative of NSView and get it's window when the view is added into view hierarchy.
Here it can be done via `.background` modifier. The resulting window is passed back via binding.

![aZ2BF](https://user-images.githubusercontent.com/62171579/166149921-b71a9abc-b633-469c-9efc-af29e0f95be2.png)


```
class AuthStore {
    var window: NSWindow

    init(window: NSWindow) {
        self.window = window
    }
}

struct DemoWindowAccessor: View {
    @State private var window: NSWindow?   // << detected in run-time so optional
    var body: some View {
        VStack {
            if nil != window {
                LoginView(store: AuthStore(window: window!))    // << usage
            }
        }.background(WindowAccessor(window: $window))
    }
}

struct WindowAccessor: NSViewRepresentable {
    @Binding var window: NSWindow?

    func makeNSView(context: Context) -> NSView {
        let view = NSView()
        DispatchQueue.main.async {
            self.window = view.window   // << right after inserted in window
        }
        return view
    }

    func updateNSView(_ nsView: NSView, context: Context) {}
}

struct LoginView: View {
    let store: AuthStore

    var body: some View {
        Text("LoginView with Window: \(store.window)")
    }
}
```
