```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: SwiftUI - State change in UITextField causes the frameWidth to grow uncontrolled and ignore bounds/frame (by denninho)

A: You need to decrease priority of content resistance in `makeUIView` (so content would not push external layout set in SwiftUI) like below


    func makeUIView(context: UIViewRepresentableContext<MyField>) -> UITextField {
        let field = UITextField(frame: .zero)
        field.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        ...

