```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: SwiftUI - How to make a vertical dotted line using Shape? (by Tariq)

A: Make `DottedLine` react both on width and height and configure as needed in place of useage:

![ZhdkP](https://user-images.githubusercontent.com/62171579/171984513-04ae68c0-22e5-446c-b057-6ba66513b272.png)

```
struct DottedLine: Shape {
        
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: rect.height))
        return path
    }
}

struct TestDottedLineView: View {
  var body: some View {
    DottedLine()
      .stroke(style: StrokeStyle(lineWidth: 1, dash: [2]))
      .frame(width: 1, height: 100)
      .foregroundColor(Color.red)
  }
}
```
