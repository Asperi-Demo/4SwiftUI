```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: SwiftUI: LocalizedStringKey with indices (by Michael)

> "Question1"       = "blablabla";<br>
> "Question2"       = "blablablub";<br>
> "Question3"       = "bliblablub";<br>

A: Here is a solution. Tested with Xcode 12.1 / iOS 14.1

    ForEach (1..<4) { value in
        Text(LocalizedStringKey(stringLiteral: "Question\(value)"))
    }
