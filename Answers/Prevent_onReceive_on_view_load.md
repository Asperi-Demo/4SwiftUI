```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
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
