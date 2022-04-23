```
BOYCOTT on ᵣussia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: SwiftUI: observe @Environment property changes (by matteopuc)

A: `Environment` gives you access to what is stored under `EnvironmentKey` but does 
not generate observer for its internals (ie. you would be notified if value of 
`EnvironmentKey` changed itself, but in your case it is instance and its reference 
stored under key is not changed). So it needs to do observing manually, is you have 
publisher there, like below

    @Environment(\.intGenerator) var intGenerator: IntGenerator
    
    @State private var value = 0
    var body: some View {
        Text("\(value)")
            .onReceive(intGenerator.$newValue) { self.value = $0 }    // << here !!
    }

and all works... tested with Xcode 11.2 / iOS 13.2
