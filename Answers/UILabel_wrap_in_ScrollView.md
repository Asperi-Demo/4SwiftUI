```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: Size a UILabel in SwiftUI via UIViewRepresentable like Text to wrap multiple lines (by Jordan H)

A: The problem here is in `ScrollView` which requires definite height, but representable does not provide it. The possible solution is to dynamically calculate wrapped text height and specify it explicitly.

*Note: as height is calculated dynamically it is available only in run-time, so cannot be tested with Preview.*

Tested with Xcode 12 / iOS 14

![SfQEW](https://user-images.githubusercontent.com/62171579/165965907-75bbea40-075c-4201-b116-774628a35791.gif)

```
struct LabelView: View {
    var text: String

    @State private var height: CGFloat = .zero

    var body: some View {
        InternalLabelView(text: text, dynamicHeight: $height)
            .frame(minHeight: height)
    }

    struct InternalLabelView: UIViewRepresentable {
        var text: String
        @Binding var dynamicHeight: CGFloat

        func makeUIView(context: Context) -> UILabel {
            let label = UILabel()
            label.numberOfLines = 0
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
