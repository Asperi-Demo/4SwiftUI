```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: Same ForEach loop twice in one SwiftUI View (by D. Mika)

A: If you really need that kind of grid filling, then it is possible just to use different identifiers for those `ForEach` containers, like

        LazyVGrid(columns: gridItems, alignment: .leading, spacing: 2) {
            ForEach(data.items) { item in
                Text(item.name).id("\(item.id)-1")      // << here !!
            }
            ForEach(data.items) { item in
                Text(item.description).id("\(item.id)-2")    // << here !!
            }
        }

Tested with Xcode 13beta / iOS 15
