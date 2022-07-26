```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: SwiftUI + Dynamic action closure for Button (by Kampai)

A: Button update ...

    struct RoundButton: View {
        var image: String
        var title: String
        var action: () -> Void        // << here !!
    
        var body: some View {
            VStack {
                Button(action: action) {      // << here !!
                    Image(image)
                       .renderingMode(Image.TemplateRenderingMode?.init(Image.TemplateRenderingMode.template))
                }
        ...

Usage update ...

    RoundButton(image: "chat", title: "message") {
        print("Button pressed")
    }

