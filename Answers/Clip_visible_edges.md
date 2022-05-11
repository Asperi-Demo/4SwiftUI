```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: SwiftUI edges visible after using overlay (by M1X)

A: Your view will not be tappable through overlay, even with transparency, so the solution is to use clip shape and background as shown below


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
