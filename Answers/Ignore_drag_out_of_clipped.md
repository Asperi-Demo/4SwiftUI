```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: In SwiftUI, how can you make a gesture inactive outside a container view? (by rliebert)

A: Here is possible solution. The idea is to have drag coordinates in container coordinate space and ignore drag if start location is out of that named area.

Tested with Xcode 11.4 / iOS 13.4

![eMcjy](https://user-images.githubusercontent.com/62171579/169651655-40956e8c-1844-4a9f-80ac-0303654911b0.gif)

```
struct ContentView: View {

    @State var position: CGPoint = CGPoint(x: 100, y: 150)
    @State var lastPosition: CGPoint = CGPoint(x: 100, y: 150)

    var body: some View {
        let area = CGRect(x: 0, y: 0, width: 200, height: 300)

        let drag = DragGesture(coordinateSpace: .named("area"))
        .onChanged {
            guard area.contains($0.startLocation) else { return }
            self.position = CGPoint(x: $0.translation.width + self.lastPosition.x, y: $0.translation.height + self.lastPosition.y)
        }
        .onEnded {_ in
            self.lastPosition = self.position
        }

        return VStack {
            Rectangle().foregroundColor(.red)
                .frame(width: 150, height: 150)
                .position(self.position)
                .gesture(drag)
                .clipped()
        }
        .background(Color.green)
        .frame(width: area.size.width, height: area.size.height)
        .coordinateSpace(name: "area")

    }
}
```
