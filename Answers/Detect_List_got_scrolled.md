```
BOYCOTT on ᵣussia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
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
