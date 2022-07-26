```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: SwiftUI prevent onReceive from firing on load (by Dennis Calla)

A: It is publisher, so fires as soon as subscriber attached, ie. on view constructed. Thus the solution it to use any applicable 
combine operators. In this case `.dropFirst` solves the task:
     
    @EnvironmentObject var appState: AppState

    // ... other code

    SomeView()
        .onReceive(appState.$test.dropFirst()) { test in
            print("Hello from onReceive: \(test)")
        }
