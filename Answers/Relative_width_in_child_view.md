```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: How to set relative width in a HStack embedded in a ForEach in SwiftUI? (by Danny Richard Aboo)

```
struct FatherList: View {
    let attributes: Attributes
    
    init(_ attributes: Attributes) {
        self.attributes = attributes
    }
    
    var body: some View {
        VStack(spacing: CGFloat.spacing.medium) {
            ForEach(
                attributes,
                id: \.name,
                content: ChildView.init
            )
        }
    }
}
```

A: Here is a demo of possible solution. Tested with Xcode 11.4 / iOS 13.4

![OLGBM](https://user-images.githubusercontent.com/62171579/175788207-d9f22cbe-c2a7-4dcf-a4d3-c69d278a87a9.png)

Note: `ViewHeightKey` is taken from [this another my solution](https://github.com/Asperi-Demo/4SwiftUI/blob/master/Answers/Card_to_full_screen.md)

```
struct ChildView: View {
    let attribute: Attribute

    @State private var fitHeight = CGFloat.zero

    var body: some View {
        GeometryReader { geometry in
            HStack(alignment: .top, spacing: 0) {
                Text(self.attribute.name)
                    .bold()
                    .frame(width: 0.3 * geometry.size.width, alignment: .leading)
                    .background(Color.yellow)
                Text(self.attribute.value)
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(width: 0.7 * geometry.size.width, alignment: .leading)
            }
            .background(Color.red)
            .background(GeometryReader {
                Color.clear.preference(key: ViewHeightKey.self,
                    value: $0.frame(in: .local).size.height) })
        }
        .onPreferenceChange(ViewHeightKey.self) { self.fitHeight = $0 }
        .frame(height: fitHeight)
    }
}
```
