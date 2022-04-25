```
BOYCOTT on ᵣussia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: DatePicker is it possible to display date/time in other timezone then current? (by Michał Ziobro)

A: It is possible to do with SwiftUI `.environment` modifier as in below example

    DatePicker("Due Date", selection: $selected,
        displayedComponents: [.date, .hourAndMinute]
    )
    .environment(\.timeZone, TimeZone(secondsFromGMT: 5*60*60)!)     // << here !!

