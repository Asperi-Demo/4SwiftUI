```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: SwiftUI -- Detect DragGesture cancellation when iPad dock is pulled up (by appthumb)

A: Try with `GestureState` as follows. It is temporary, by default, and when ended is reset to initial value by design.

    struct ContentView: View {
      @GestureState private var offset = CGSize.zero
    
      var body: some View {
        ZStack {
          Rectangle()
            .fill(Color.clear)
            .frame(width: 100, height: 100)
            .border(Color.black, width: 5)
    
          Circle()
            .fill(Color.red)
            .frame(width: 90, height: 90)
            .offset(offset)
            .gesture(
              DragGesture()
                .updating($offset) { (value, gestureState, transaction) in
                    gestureState = CGSize(width: value.location.x - value.startLocation.x, height: value.location.y - value.startLocation.y)
                })
        }
      }
    }

