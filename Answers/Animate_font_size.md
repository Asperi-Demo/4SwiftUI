```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: How can I animate the font size of Text from .largeTitle to .headline (by user1354934)

A: Font size is not animatable by default. The below solution is based on custom animatable modifier.

Tested with Xcode 12 / iOS 14

![31iwJ](https://user-images.githubusercontent.com/62171579/175238687-46e95602-ff0e-42cd-9c9e-028636b46b6e.gif)

```
struct AnimatingFontSize: AnimatableModifier {
    var fontSize: CGFloat

    var animatableData: CGFloat {
        get { fontSize }
        set { fontSize = newValue }
    }

    func body(content: Self.Content) -> some View {
        content
            .font(.system(size: self.fontSize))
    }
}

struct DemoFontView: View {
    @State private var smallFont = false

    var body: some View {
        Text("Big Text - Small Text")
            .frame(maxWidth: .infinity)
            .modifier(AnimatingFontSize(fontSize: smallFont ? 11 : 100))
            .animation(Animation.linear(duration: 10), value: smallFont)
            .onAppear {
                smallFont = true
            }
    }
}
```
