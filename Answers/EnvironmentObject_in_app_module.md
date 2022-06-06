```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
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
