```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: SwiftUI set position to center of different view (by KevinP)

A: Here is possible approach (with a bit simplified your initial snapshot and added some convenient `View` extension).

Tested with Xcode 11.2 / iOS 13.2

![tnf76](https://user-images.githubusercontent.com/62171579/168628342-1fd5aab4-0c21-458c-a3be-95b7675db544.gif)

    extension View {
        func rectReader(_ binding: Binding<CGRect>, in space: CoordinateSpace) -> some View {
            self.background(GeometryReader { (geometry) -> AnyView in
                let rect = geometry.frame(in: space)
                DispatchQueue.main.async {
                    binding.wrappedValue = rect
                }
                return AnyView(Rectangle().fill(Color.clear))
            })
        }
    }
    
    struct ContentView: View {
    
        @State private var tap = false
        @State private var bottomRect: CGRect = .zero
    
        var body: some View {
            ZStack(alignment: .bottom) {
                RoundedRectangle(cornerRadius: 10)
                    .frame(maxWidth: .infinity, maxHeight: 50, alignment: .center)
                    .padding()
                    .rectReader($bottomRect, in: .named("board"))
    
                Rectangle()
                    .foregroundColor(.red)
                    .overlay(Text("Click me")
                        .fontWeight(.light)
                        .foregroundColor(.white)
                    )
                    .frame(width: 50, height: 50)
                    .position(x: self.tap ? bottomRect.midX : 50,
                              y: self.tap ? bottomRect.midY : 50)
                    .onTapGesture {
                        withAnimation {
                            self.tap.toggle()
                        }
                    }
            }.coordinateSpace(name: "board")
        }
    }
