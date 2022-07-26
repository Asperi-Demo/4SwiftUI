```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

A: SwiftUI - Unable to change color of Image icon (by C. Skjerdal)

Q: I'm not sure what are you trying to to achieve, but probably you just need template rendering mode, like

    Image(self.icon)
        .renderingMode(.template)
        .foregroundColor(.white)

