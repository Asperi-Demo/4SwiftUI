```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: SwiftUI edges visible after using overlay (by M1X)

A: Your view will not be tappable through overlay, even with transparency, so the solution is to use clip shape and background as shown below

![HSpRU](https://user-images.githubusercontent.com/62171579/167899445-cc9b153c-9f89-45a0-8abf-ca3ef5752aaa.png)

```
struct DemoRoundRectView: View {
    var body: some View {
        Text("DEMO")
            .frame(width: 100, height: 50)
            .background(Color.gray.opacity(0.2))
            .clipShape(RoundedRectangle(cornerRadius: 10)) // clip corners
            .background(
                RoundedRectangle(cornerRadius: 10) // stroke border
                    .stroke(Color.gray.opacity(0.2), lineWidth: 1)
            )
    }
}
```
