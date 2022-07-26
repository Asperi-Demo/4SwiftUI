```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: Align views in Picker (by George)

A: Possible solution is to use dynamic width for labels applied by max calculated one using view preferences.

Here is a demo. Tested with Xcode 13beta / iOS15

![nXj42](https://user-images.githubusercontent.com/62171579/172928414-aaa17849-f83e-4ecd-87a5-c9cf791ece1b.gif)

```
struct ContentView: View {
  @State private var colorName: Colors = .red
  @State private var maxWidth = CGFloat.zero

  var body: some View {
    Picker("Select color", selection: $colorName) {
      ForEach(Colors.allCases) { color in
        HStack {
          color.asColor.aspectRatio(contentMode: .fit)
          Text(color.rawValue)
        }
        .background(GeometryReader {
          Color.clear.preference(key: ViewWidthKey.self, 
                        value: $0.frame(in: .local).size.width)
        })
        .onPreferenceChange(ViewWidthKey.self) {
          self.maxWidth = max($0, maxWidth)
        }
        .frame(minWidth: maxWidth, alignment: .leading)
      }
    }
  }
}

struct ViewWidthKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}
```
