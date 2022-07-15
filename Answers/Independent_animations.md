```
🔥BOYCOTT on russia - terrorist must be punished!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: How to keep the initial animation running while a new one is performed? (by darekm)

A: We need to separate circle into own view with own animation, then internal animation will be independent of external animation.

Here is a demo of solution on somehow replicated code. Prepared with Xcode 12.1 / iOS 14.1.

![by54P](https://user-images.githubusercontent.com/62171579/179245727-51dd6f49-c2d2-40fc-89af-75f4ff024575.gif)

```
struct Ball: Identifiable, Hashable {
  let id = UUID()
  var position = CGPoint.zero
  
  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
}

struct BallView: View {
  let ball: Ball
  var color = Color.blue
  @State private var size = CGSize(width: 40, height: 40)
  var body: some View {
    Circle()
      .frame(width:size.width, height: size.height) //self.size is a state var
      .animation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true), value: size)
      .foregroundColor(color)
      .onAppear {
        size = CGSize(width: size.width+20, height: size.height+20)
      }
  }
}

struct ContentView: View {
  @State private var balls = [Ball(position: CGPoint(x: 100, y: 100)), Ball(position: CGPoint(x: 100, y: 200))]
  @State private var off = CGSize.zero
  @State private var selected = -1
  var body: some View {
    
    ZStack {
      ForEach (Array(balls.enumerated()), id: \.1) { i, ball in
        BallView(ball: ball)
          .offset(x: i == selected ? off.width : 0, y: i == selected ? off.height : 0)
          .position(ball.position)
          .gesture(DragGesture()
            .onChanged { gesture in
              self.selected = i
              withAnimation(.default) {
                self.off = gesture.translation
              }
            }
            .onEnded { gesture in
                let pt = balls[i].position
                self.balls[i].position = CGPoint(x: pt.x + gesture.translation.width, y: pt.y + gesture.translation.height)
                self.off = .zero
                self.selected = -1
//               ballStorage.checkOverlaps(for: numberInArray)
            }
          )
      }
    }
  }
}
```
