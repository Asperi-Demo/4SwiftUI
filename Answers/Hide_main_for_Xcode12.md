```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: use @main in Xcode 12 (by Alireza12t)

A: This might depend on other project code, but the following tested as works (Xcode 12b), so might be helpful.

The idea is to hide one wrapper inside another structure with availability checker:

```
@available(iOS 14.0, macOS 10.16, *)
struct Testing_SwiftUI2AppHolder {
    @main
    struct Testing_SwiftUI2App: App {

        var body: some Scene {
            WindowGroup {
                ContentView()
            }
        }
    }
}
```
