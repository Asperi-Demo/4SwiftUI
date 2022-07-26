```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: How to use EnvironmentObject in app file in SwiftUI (by alionthego)

A: You can use it as regular property at that level and pass as environment down into view hierarchy if/when needed, like

```
struct ExampleApp: App {

    let userAuth = UserAuth()     // << here !!
    
    var body: some Scene {
        WindowGroup {
            switch userAuth.loginStatus {
            case .signedIn:
                ContentView()
                   .environmentObject(userAuth)    // << here !!
            case .signedOut:
                Text("Signed Out")
            }
        }
    }
}
```
