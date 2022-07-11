```
🔥BOYCOTT on russia - terrorist must be punished!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: swiftUI, moving the view to where I tapped (by Seungjun)

A: Here is a possible solution. It needs to grab frame of each box in same coordinate space as circle moves, and then calculate needed translation. (Also extraction refactoring made, to helper function, to avoid code duplication).

Tested with Xcode 11.4 / iOS 13.4

Re-tested with Xcode 13.4 / iOS 15.5

![fczQH](https://user-images.githubusercontent.com/62171579/178296291-078814b6-a2b1-4bff-8dfe-e1c7c4c5af86.gif)

```
struct ContentView: View {
    @State private var currentPos: CGSize = .zero
    @State private var newPos: CGSize = .zero

    private func generateBox(in usa: GeometryProxy) -> some View {
        Rectangle().frame(width: 100, height: 100).overlay(GeometryReader { gp in
            Color.black.onTapGesture {
                let area = usa.frame(in: CoordinateSpace.global)
                let frame = gp.frame(in: CoordinateSpace.global)
                let position = CGSize(width: frame.midX - area.midX, height: frame.midY - area.midY)

                self.newPos = position
                withAnimation {
                    self.currentPos = position
                }
            }
        })
    }

    var body: some View {
        GeometryReader { usa in
            ZStack{
                VStack{
                	Spacer()
                    HStack{
                        self.generateBox(in: usa)
                        Spacer()
                        self.generateBox(in: usa)
                    }

                    HStack{
                        self.generateBox(in: usa)
                        Spacer()
                        self.generateBox(in: usa)
                    }
                	Spacer()
                }
                //end of VStack
                redCircleView()
                    .offset(x: self.currentPos.width, y: self.currentPos.height)
                    .gesture(DragGesture()
                        .onChanged { value in
                            self.currentPos = CGSize(width: value.translation.width + self.newPos.width, height: value.translation.height + self.newPos.height)

                    }
                    .onEnded { value in
                        self.currentPos = CGSize(width: value.translation.width + self.newPos.width, height: value.translation.height + self.newPos.height)

                        self.newPos = self.currentPos
                        }
                )

            }
        }
    }
}
```
