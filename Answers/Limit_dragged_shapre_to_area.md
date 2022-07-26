```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: Limit rectangle to screen edge on drag gesture (by Ross Moody)

A: A drag gesture is not limited to a view from which it is originated. The view only specifies
context: default coordinate space and a handler of events, so we need to add any restrictions
manually, where/when needed. 

Here is a demo of possible approach (for any view, cause view frame is read dynamically).

Tested with Xcode 12 / iOS 14

![VySqj](https://user-images.githubusercontent.com/62171579/167241495-0551b6d1-bf0a-4c3b-9377-3ebc6b27c505.gif)

```
struct ViewSizeKey: PreferenceKey {
    static var defaultValue = CGSize.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value = nextValue()
    }
}

struct ContentView: View {
    @State private var pogPosition = CGPoint()
    @State private var size = CGSize.zero

    var body: some View {
        GeometryReader { gp in
            PogSound()
                .background(GeometryReader {
                    Color.clear
                        .preference(key: ViewSizeKey.self, value: $0.frame(in: .local).size)
                })
                .onPreferenceChange(ViewSizeKey.self) {
                    self.size = $0
                }
                .position(pogPosition)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            let rect = gp.frame(in: .local)
                                .inset(by: UIEdgeInsets(top: size.height / 2.0, left: size.width / 2.0, bottom: size.height / 2.0, right: size.width / 2.0))
                            if rect.contains(value.location) {
                                self.pogPosition = value.location
                            }
                        }
                        .onEnded { value in
                            print(value.location)
                        }
            )
            .onAppear {
                let rect = gp.frame(in: .local)
                self.pogPosition = CGPoint(x: rect.midX, y: rect.midY)
            }
        }.edgesIgnoringSafeArea(.all)
    }
}
```
