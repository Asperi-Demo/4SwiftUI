```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: SwiftUI: how to detect when List is scrolled? (by pejalo)

A: I recommend to use `simultaneousGesture` modifier as in below:

    List {
      // ... your list items
    }
    .simultaneousGesture(DragGesture().onChanged({ _ in
        // if keyboard is opened then hide it
    }))

[Complete test module is here](https://github.com/Asperi-Demo/4SwiftUI/blob/master/PlayOn_iOS/PlayOn_iOS/Findings/TestDetectListBeginToScroll.swift)
