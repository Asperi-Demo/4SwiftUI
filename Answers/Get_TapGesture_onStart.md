```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: SwiftUI TapGesture onStart / TouchDown (by davidev)

A: If by pure SwiftUI then only indirectly for now. 

Here is an approach. Tested with Xcode 11.4.

*Note: `minimumDistance: 0.0` below is important !!*

```
MyView()
    .gesture(DragGesture(minimumDistance: 0.0, coordinateSpace: .global)
        .onChanged { _ in
            print(">> touch down") // additional conditions might be here
        }
        .onEnded { _ in
            print("<< touch up")
        }
    )
```
