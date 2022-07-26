```
🔥BOYCOTT on russia - terrorist must be punished!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: How does SwiftUI pass EnvironmentObjects between HostingController? (by Raphaël Barthomeuf)

A: Here is possible approach

```
class AppState: ObservableObject {
    static let shared = AppState()      // shared instance

    @Published var setting: String = "some"
}

class HostingController: WKHostingController<AnyView> {
    override var body: AnyView {
        let contentView = ContentView()
            .environmentObject(AppState.shared)     // << inject !!
        return AnyView(contentView)
    }
}

class HostingController2: WKHostingController<AnyView> {
    override var body: AnyView {
        let contentView = ContentView2()
            .environmentObject(AppState.shared)     // << inject !!
        return AnyView(contentView)
    }
}
```
