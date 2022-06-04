```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: SwiftUI: LocalizedStringKey with indices (by Michael)

> "Question1"       = "blablabla";<br>
> "Question2"       = "blablablub";<br>
> "Question3"       = "bliblablub";<br>

A: Here is a solution. Tested with Xcode 12.1 / iOS 14.1

    ForEach (1..<4) { value in
        Text(LocalizedStringKey(stringLiteral: "Question\(value)"))
    }
