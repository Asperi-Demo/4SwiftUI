```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: Interaction of DragGesture and ScrollView in SwiftUI (by Baglan)

A: For such temporary states it is better to use `GestureState` as it is automatically reset to initial state after gesture cancels/finished.

So here is possible approach

Demo:

![5PCfO](https://user-images.githubusercontent.com/62171579/170683071-213d2ec7-c55f-48f0-9a59-278c7e47f958.gif)

Code: 

    struct Sample: View {
        @GestureState private var dragOffset: CGFloat = -100
        var body: some View {
            VStack {
    
                Text("Perhaps a title")
    
                ScrollView {
                    VStack {
                        Text("Some scrollable content is going to be here")
    
                        // ...
    
                        Button(action: {
                            // Go to the next slide
                        }) { Text("Next") }
                    }
                }
    
                Text("and, maybe, something else")
            }
            .overlay(
                Image(systemName: "arrow.left").offset(x: dragOffset / 2),
                alignment: .leading
            )
            .gesture(
                DragGesture()
                    .updating($dragOffset) { (value, gestureState, transaction) in
                        let delta = value.location.x - value.startLocation.x
                        if delta > 10 { // << some appropriate horizontal threshold here
                            gestureState = delta
                        }
                    }
                    .onEnded {
                        if $0.translation.width > 100 {
                            // Go to the previous slide
                        }
                    }
            )
        }
    }

Note: `dragOffset: CGFloat = -100` this might have different effect on different real devices, so probably it is better to calculate it explicitly.
