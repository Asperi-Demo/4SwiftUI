```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: Make SwiftUI Rectangle same height or width as another Rectangle (by wigging)

A: Here is a working approach, based on view preferences. Tested with Xcode 11.4 / macOS 10.15.6

![aYPkH](https://user-images.githubusercontent.com/62171579/168469484-cdd85c32-2470-4a07-b722-8e0a88796c8e.png)

```
struct ViewWidthKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue: CGFloat { 0 }
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value = value + nextValue()
    }
}

struct ContentView: View {
    @State private var boxWidth = CGFloat.zero
    var body: some View {
        VStack {
            HStack {
                ZStack {
                    Rectangle()
                        .fill(Color.purple)
                        .frame(width: 20)
                    Text("1")
                        .font(.subheadline)
                        .foregroundColor(.white)
                }

                ZStack {
                    Rectangle()
                        .fill(Color.orange)
                    Text("2")
                        .font(.subheadline)
                        .foregroundColor(.white)
                }
                .background(GeometryReader {
                    Color.clear.preference(key: ViewWidthKey.self,
                        value: $0.frame(in: .local).size.width) })
            }

            HStack {
                ZStack {
                    Rectangle()
                        .fill(Color.red)
                        .frame(height: 20)
                    Text("3")
                           .font(.subheadline)
                           .foregroundColor(.white)
                }.frame(width: boxWidth)
            }.frame(maxWidth: .infinity, alignment: .bottomTrailing)
        }
        .onPreferenceChange(ViewWidthKey.self) { self.boxWidth = $0 }
        .frame(minWidth: 400, minHeight: 250)
    }
}
```
