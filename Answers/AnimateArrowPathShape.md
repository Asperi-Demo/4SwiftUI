```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: SwiftUI | Animate This Path Shape (by Mofawaw)

![ZvE4G](https://user-images.githubusercontent.com/62171579/168001714-ed9fa863-2717-40ef-8e24-b65e71704c80.gif)

A: Here is possible approach - move path into custom shape and make changed parameter as animatable property. Tested with Xcode 12 / iOS 14

![g2Rv1](https://user-images.githubusercontent.com/62171579/168001619-ab72c32e-4808-4147-a9eb-b4f9e1aa54b2.gif)

```
struct MyArrow: Shape {
	var width: CGFloat
	var offset: CGFloat
	
	var animatableData: CGFloat {
		get { offset }
		set { offset = newValue }
	}
	
	func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: .zero)
            path.addLine(to: CGPoint(x: width/2, y: offset))
            path.move(to: CGPoint(x: width/2, y: offset))
            path.addLine(to: CGPoint(x: width, y: 0))
        }
	}
}

struct ContentView: View {
    
    @State private var change = false
    
    private let arrowWidth: CGFloat = 80
    
    
    var body: some View {
		MyArrow(width: arrowWidth, offset: change ? -20 : 20)
        .stroke(style: StrokeStyle(lineWidth: 12, lineCap: .round))
        .frame(width: arrowWidth)
        .foregroundColor(.green)
        .contentShape(Rectangle())
        .onTapGesture { withAnimation { change.toggle() } }
        .onTapGesture { change.toggle() }
        .padding(.top, 300)
    }
}
```
