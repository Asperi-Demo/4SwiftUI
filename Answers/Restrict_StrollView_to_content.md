```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: SwiftUI ScrollView does not center content when content fits scrollview bounds (by andrewz)

A: You observe just normal ScrollView behaviour. Here is a demo of possible approach to achieve your goal.

![wt3OB](https://user-images.githubusercontent.com/62171579/170870790-2fa65769-19e8-4879-824e-ffc08187b9c6.gif)

```
// view pref to detect internal content height
struct ViewHeightKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue: CGFloat { 0 }
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value = value + nextValue()
    }
}

// extension for modifier to detect view height
extension ViewHeightKey: ViewModifier {
    func body(content: Content) -> some View {
        return content.background(GeometryReader { proxy in
            Color.clear.preference(key: Self.self, value: proxy.size.height)
        })
    }
}

// Modified your view for demo
struct TestAdjustedScrollView: View {
    @State private var count : Int = 100

    @State private var myHeight: CGFloat? = nil
    var body : some View {
        GeometryReader { gp in
            ScrollView {
                VStack {
                    Button(action: {
                        if self.count > 99 {
                            self.count = 5
                        } else {
                            self.count = 100
                        }
                    }) {
                        Text("CLICK")
                    }
                    ForEach(0...self.count, id: \.self) { no in
                        Text("entry: \(no)")
                    }
                }
                .padding(8)
                .border(Color.red)
                .frame(alignment: .center)
                .modifier(ViewHeightKey())   // read content view height !!
            }
            .onPreferenceChange(ViewHeightKey.self) {
                // handle content view height
                self.myHeight = $0 < gp.size.height ? $0 : gp.size.height
            }
            .frame(height: self.myHeight) // align own height with content
            .border(Color.blue)
            .padding(8)
        }
    }
}
```
