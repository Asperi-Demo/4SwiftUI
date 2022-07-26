```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: how to detect long press on Button? (by alamodey)

A: Here is possible variant (tested with Xcode 11.2 / iSO 13.2). 

    Button("Demo") {
        print("> tap")
    }
    .simultaneousGesture(LongPressGesture().onEnded { _ in
        print(">> long press")
    })

