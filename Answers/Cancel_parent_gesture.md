```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: SwiftUI: Cancel TapGesture on parent view (by Michał Ziobro)

A: Well, probably there is some specific in which exactly `ChildView` and `ParentView`, because as tested below (Xcode 11.2 / iOS 13.2) child view gesture just overrides parent view gesture.

Here is demo.. tapped in yellow area, then tapped in green area - no mix callbacks

![SGl3A](https://user-images.githubusercontent.com/62171579/168439394-0aa3926f-36ad-4770-b8a7-83ddd54f9193.png)

Complete module code

    import SwiftUI
    
    struct TestGesturesPriority: View {
        var body: some View {
            VStack {
                Text("Hello, World!")
                    .padding()
                    .background(Color.yellow)
                    .gesture(TapGesture().onEnded {
                        print(" -- child")
                    })
            }
            .frame(width: 400, height: 400)
            .background(Color.green)
            .gesture(TapGesture().onEnded {
                print(">> parent")
            })
        }
    }
    

**Update:** variant for `List-Row`

Yeees... *List (Parent) - Row (Child)* case appeared very challenging... please find below approach, it looks weird but tested & works


    struct TestGesturesPriority: View {
    
        let parentGesture = TapGesture().onEnded { // just for convenience
            print(">> parent")
        }
        
        @GestureState private var captured = false
        var body: some View {
            List {
                Text("Hello, World!").padding()
                        .background(Color.yellow)
                        .allowsHitTesting(true)
                        .gesture(DragGesture(minimumDistance: 0) // mimic Tap
                            .updating($captured, body: { (value, state, transaction) in
                            state = true // mark captured (will be reset automatically)
                        })
                        .onEnded { value in
                            // like Tap, but can be ignored if delta 
                            // is large or out of view
                            print(" -- child")
                        }
                    )
            }
            .gesture(parentGesture, including: captured ? .subviews : .gesture)
        }
    }


To summarise - actually I think it is another List defect
