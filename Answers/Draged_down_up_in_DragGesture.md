```
BOYCOTT on ᵣussia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: How to know if draged down or up while using DragGesture() in SwiftUI? (by New iOS Dev)

A: A possible approach is to have additional state property to store
`value.location.y` coordinate and update dependent state comparing
previously stored and currently received in drag `value`:

Tested with Xcode 13.3 / iOS 15.4

![ezgif com-gif-maker-41](https://user-images.githubusercontent.com/62171579/165132749-02f9ec02-dbb8-423c-b7cf-9c78351f66ea.gif)

Here is main part:

```
  @State var current: CGFloat? = nil // << any initial
  @State var isUp = false

  // .. other code

      Circle().fill(.blue).frame(width: 100)
          .offset(x: 0, y: offsetY)
          .gesture(DragGesture()
            .onChanged { value in
              let newValue = value.location.y     // << prev
              if let prev = self.current {
                self.isUp = prev > newValue       // compare !!
              }
              self.current = newValue             // >> next
              self.offsetY = value.translation.height
            }
            .onEnded { _ in
              self.current = nil
              self.offsetY = 0
            })

        if current != nil {
          Text(isUp ? "Up" : "Down")      // << here !!
        }
```

[Test module in project is here](https://github.com/Asperi-Demo/4SwiftUI/blob/master/PlayOn_iOS/PlayOn_iOS/Findings/TestDragGestureDirection.swift)

