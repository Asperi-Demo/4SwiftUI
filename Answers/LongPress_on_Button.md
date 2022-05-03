```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: how to detect long press on Button? (by alamodey)

A: Here is possible variant (tested with Xcode 11.2 / iSO 13.2). 

    Button("Demo") {
        print("> tap")
    }
    .simultaneousGesture(LongPressGesture().onEnded { _ in
        print(">> long press")
    })

