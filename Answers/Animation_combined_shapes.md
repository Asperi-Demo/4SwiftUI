```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: SwiftUI Circle View animation glitch (by GuilhE)

A: It is unclear definitely, probably due to undefined size of shapes as a nature... Anyway, seems using drawing group fixes the issue.

Here is a fixed code. Tested with Xcode 13 / iOS 15.

![vBMPl](https://user-images.githubusercontent.com/62171579/170943347-09e16624-d197-436e-b47a-9deca8a9061b.gif)

```
struct CircularProgressView: View {

  @Binding var progress: Float
  private let strokeStyle = StrokeStyle(lineWidth: 30.0, lineCap: .round, lineJoin: .round)
  private let rotation = Angle(degrees: 270.0)

  var body: some View {
    ZStack {
      Group {
        Circle()
          .trim(from: 0.0, to: CGFloat(min(self.progress, 1.0)))
          .stroke(style: strokeStyle)
          .opacity(0.2)
          .foregroundColor(Color.black)
          .rotationEffect(rotation)
          .offset(x: 0, y: 10)
        Circle()
          .trim(from: 0.0, to: CGFloat(min(self.progress, 1.0)))
          .stroke(style: strokeStyle)
          .opacity(1)
          .foregroundColor(Color.white)
          .rotationEffect(rotation)
      }
      .padding()    // << compensate offset within own bounds
    }
    .drawingGroup()   // << here !!
    .animation(.linear, value: progress)
  }
}

struct CircularProgressView_Previews: PreviewProvider {
  static var previews: some View {
    OtherView(progress: 0.6)
  }

  struct OtherView : View {

    @State var progress : Float = 0.0

    var body: some View {
      ZStack {
        Color.yellow
        VStack {
          CircularProgressView(progress: self.$progress)
            .padding()
          Button(action: {
            if(progress >= 1) {
              progress = 0
            } else {
              progress += 0.1
            }
          }) {
            Text("try me")
              .frame(width: 200, height: 50)
              .overlay(
                RoundedRectangle(cornerRadius: 20)
                  .stroke(Color.blue, lineWidth: 2)
              )
              .padding(.bottom, 100)
          }
        }
      }.ignoresSafeArea()
    }
  }
}
```
