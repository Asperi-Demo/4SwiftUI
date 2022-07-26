```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: SwiftUI - Sliding Text animation and positioning (by Oleg G.)

A: Here is a possible simple approach - the idea is just as simple as to change text alignment in container, anything else can be tuned as usual.

Demo prepared & tested with Xcode 12 / iOS 14

![Npo62](https://user-images.githubusercontent.com/62171579/169596662-d708ce66-fe3d-45a8-815b-8eff56177084.gif)

![ezgif com-gif-maker-66](https://user-images.githubusercontent.com/62171579/169596829-9255099a-7231-4dba-b0b8-3629e8f6e0ac.gif)

```
struct DemoSlideText: View {
    let text = "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor"

    @State private var go = false
    var body: some View {
        VStack {
            Text(text)
        }
        .fixedSize()
        .frame(width: 300, alignment: go ? .trailing : .leading)
        .clipped()
        .onAppear { self.go.toggle() }
        .animation(Animation.linear(duration: 5).repeatForever(autoreverses: true))
    }
}
```
