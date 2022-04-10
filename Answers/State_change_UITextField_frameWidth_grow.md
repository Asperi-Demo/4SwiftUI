```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

A: SwiftUI - State change in UITextField causes the frameWidth to grow uncontrolled and ignore bounds/frame (by denninho)

Q: You need to decrease priority of content resistance in `makeUIView` (so content would not push external layout set in SwiftUI) like below


    func makeUIView(context: UIViewRepresentableContext<MyField>) -> UITextField {
        let field = UITextField(frame: .zero)
        field.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        ...

