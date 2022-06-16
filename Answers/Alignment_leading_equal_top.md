```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: SwiftUI How to dynamically make a view's leading equal to its top distance to superview (by par)

A: Possible approach is to use anchor preferences, because they allows to read different position properties of targeted view and use within views layout cycle.

Here is a demo. Tested with Xcode 13.2 / iOS 15.2

![ulkWF](https://user-images.githubusercontent.com/62171579/174062685-e52cd4a2-325a-41ab-aaba-76adcbee35c2.png)

Note: used `padding` instead of `offset`, because offset does not affect layout, just in case.

```
struct PositionPreferenceKey: PreferenceKey {   // << helper key !!
    static var defaultValue: [Anchor<CGPoint>] = [] // << use something persistent

    static func reduce(value: inout [Anchor<CGPoint>], nextValue: () -> [Anchor<CGPoint>]) {
        value.append(contentsOf:nextValue())
    }
}

struct TestView: View {
	@State private var offset = CGFloat.zero

    var body: some View {
        ZStack(alignment: .blueBoxAlignment) {
            VStack(spacing: 50) {
                Text("Line 1")
                    .alignmentGuide(.blueBoxCenterAlignment) { d in d[VerticalAlignment.center] }
                Text("Line 2")
                Text("Line 3")
            }
            .padding([.top, .bottom], 50)
            .frame(maxWidth: .infinity)
            .border(.green)

            Rectangle()
                .fill(.blue)
                .opacity(0.5)
                .frame(width: 50, height: 50)
                .anchorPreference(
                    key: PositionPreferenceKey.self,
                    value: .top               // read position from top !!
                ) { [$0] }
                .padding(.leading, offset)    // << apply as X !!
        }
        .backgroundPreferenceValue(PositionPreferenceKey.self) { prefs in
            GeometryReader { gr in
            	Color.clear.onAppear {
            		self.offset = gr[prefs[0]].y  // << store Y !!
                }
            }
        }
    }
}
```
