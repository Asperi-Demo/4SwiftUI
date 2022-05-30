```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: In SwiftUI, how do I animate a view from its current position to the center of the screen? (by Milo Wyner)

A: Here is possible solution - no hardcoding, based on SwiftUI native layout engine.

Tested with Xcode 11.4 / iOS 13.4

![ZNkZ3](https://user-images.githubusercontent.com/62171579/170926961-5bb922c9-06bc-4e75-8062-e9daf1176426.gif)

```
struct DemoAnimateLayout: View {

    @State var buttonIsMoved = false

    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Text("Title")
                        .font(.largeTitle)
                    Spacer()
                }
                Spacer()
            }
            VStack {
                if !buttonIsMoved {  // <<      here !!
                    Spacer()
                }

                HStack {
                    if !buttonIsMoved {  // <<     here !!
                        Spacer()
                    }
                    // This is the button I want to animate to the center
                    Button(action: {
                        self.buttonIsMoved.toggle()
                    }) {
                        Text("This is a button")
                            .foregroundColor(.black)
                            .padding(16)
                            .background(Color.green)
                    }
                }
            }
            .animation(.easeInOut, value: buttonIsMoved)  // << animate container layout !!

        }.padding(32)
    }
}
```
