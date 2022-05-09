```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: SwiftUI EnvironmentObject not available in View initializer? (by Darrell Root)

A: **Yes, SwiftUI EnvironmentObject not available in View initializer.** Why? It is simple - 
it is injected **after** object initialiazation.

Let's consider how it is done on example of above `ContentView`:

    let contentView = ContentView(showCapture: true).environmentObject(appSettings)

so what's going on here? Here

1) instantiation & initialisation of value for the type ContentView
```
let newInstance = ContentView.init(showCapture: true) 
```

2) calling function `func environmentObject()` on `newInstance` injected `appSetting` property
```
let contentView = newInstance.environmentObject(appSettings)
```
