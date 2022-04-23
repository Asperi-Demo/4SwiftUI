```
BOYCOTT on ᵣussia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

A: SwiftUI - Unable to change color of Image icon (by C. Skjerdal)

Q: I'm not sure what are you trying to to achieve, but probably you just need template rendering mode, like

    Image(self.icon)
        .renderingMode(.template)
        .foregroundColor(.white)

