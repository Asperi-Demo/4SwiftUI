```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: Make List Sections non-collapsible in SwiftUI when embedded into a NavigationView SwiftUI (by Tamas)

A: It is default style applied, you can make it explicitly set for `List` like below (tested with Xcode 12 / iOS 14)

![uT4MI](https://user-images.githubusercontent.com/62171579/167291106-05ca395e-b167-4d46-95a1-81da38ff9673.png)

        List {
            ForEach(groups, id: \.self.name) { group in
                Section(header: Text(group.name)) {
                    ForEach(group.items, id:\.self) { item in
                        Text(item)
                    }
                }
            }
        }.listStyle(InsetGroupedListStyle()) // or GroupedListStyle

