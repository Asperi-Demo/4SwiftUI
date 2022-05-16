```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: Animating Text in SwiftUI (by Anton)

A: Here is a demo of possible approach (scratchy - you can redesign it to extension, modifier, or separate view)

Tested with Xcode 11.4 / iOS 13.4

![snEMJ](https://user-images.githubusercontent.com/62171579/168628992-1d1c554b-b2fc-423e-9cf8-d88ba420aca6.gif)

```swift
struct ContentView: View {
    @State var shortString = true
    var body: some View {
        VStack {
            if shortString {
                Text("This is short.").font(.title).fixedSize()
                .transition(AnyTransition.opacity.animation(.easeInOut(duration:1.0)))
            }
            if !shortString {
                Text("This is considerably longer.").font(.title).fixedSize()
                .transition(AnyTransition.opacity.animation(.easeInOut(duration:1.0)))
            }

            Button(action: {self.shortString.toggle()}) {
                Text("Toggle").padding()
            }
        }
    }
}
```

> Any suggestions for shrinking an animated gif's dimensions? 

    I use this way:
    - decrease zoom of Preview to 75% (or resize window of Simulator)
    - use QuickTimePlayer region-based Screen Recording
    - use https://ezgif.com/video-to-gif for converting to GIF

