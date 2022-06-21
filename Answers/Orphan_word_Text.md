```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: SwiftUI text field orphan (by iphaaw)

A: We need `lineBreakStrategy` but it is unavailable for now in SwiftUI, so possible solution is to use `UILabel`.

Here is a possible solution. Tested with Xcode 13.2 / iOS 15.2

![GmkhC](https://user-images.githubusercontent.com/62171579/174737330-9c901373-4ae2-438f-8139-f96b19280719.png)

```
struct LabelView: View {
    var text: String

    @State private var height: CGFloat = .zero

    var body: some View {
        InternalLabelView(text: text, dynamicHeight: $height)
            .frame(maxHeight: height)
    }

    struct InternalLabelView: UIViewRepresentable {
        var text: String
        @Binding var dynamicHeight: CGFloat

        func makeUIView(context: Context) -> UILabel {
            let label = UILabel()
            label.numberOfLines = 0
			label.lineBreakStrategy = .init()          // << here !!
            label.lineBreakMode = .byWordWrapping
            label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)

            return label
        }

        func updateUIView(_ uiView: UILabel, context: Context) {
            uiView.text = text

            DispatchQueue.main.async {
                dynamicHeight = uiView.sizeThatFits(CGSize(width: uiView.bounds.width, height: CGFloat.greatestFiniteMagnitude)).height
            }
        }
    }
}
```
