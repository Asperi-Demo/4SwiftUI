```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: SwiftUI detect when contextMenu is open (by charelf)

A: A possible approach is to use simultaneous gesture for this purpose, like

    Text("Demo Menu")
    	.contextMenu(menuItems: {
     		Button("Button") {}
        })
        .simultaneousGesture(LongPressGesture(minimumDuration: 0.5).onEnded { _ in
        	print("Opened")
        })

Tested with Xcode 13.2 / iOS 15.2
