```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: SwiftUI: Change the start position for animated progress bar (or Shape drawing in general) (by RGH)

A: We don't need to rotate rectangle shape (moreover shape might be not square), 
we can just create own rectangular shape with start point anywhere needed.

Demo prepared with Xcode 12.4 / iOS 14.4

![PKb1L](https://user-images.githubusercontent.com/62171579/170250959-f9422a47-ef31-43bd-8e58-eebe333ca161.gif)

```
struct MyRectangle: Shape {
  func path(in rect: CGRect) -> Path {
    Path {
      $0.move(to: CGPoint(x: rect.midX, y: rect.minY))
      $0.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
      $0.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
      $0.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
      $0.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
      $0.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
    }
  }
}

struct ContentView: View {
  @State private var progress: Double = 0
  @State private var timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()

  var body: some View {
    VStack{
      HStack{
        ZStack {
          MyRectangle()
            .stroke(lineWidth: 20.0)
            .opacity(0.3)
            .foregroundColor(Color.gray)
            .frame(width: 200, height:100)
          MyRectangle()
            .trim(from: 0.0, to: CGFloat(min(self.progress, 1.0)))
            .stroke(style: StrokeStyle(lineWidth: 20.0, lineCap: .round, lineJoin: .round))
            .foregroundColor(Color.blue)
            .animation(.linear)
            .frame(width: 200, height:100)
            .onReceive(timer, perform: { _ in
              if(progress < 100){
                progress += 0.1/10
              }
              else{
                progress = 0
              }
            })
        }
      }
      .padding()
    }
  }
}
```
