```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: How to change the Picker menu text size in SwiftUI? (by Fawzi Rifa'i)

A: If someone needs to show selected value as label (instead of static text) in this scenario, the following variant can be used

Tested with Xcode 13.2 / iOS 15.2

![Ig8pD](https://user-images.githubusercontent.com/62171579/171358946-9b3940b9-8db1-41a1-be8f-3aa4711e3a5b.gif)

    Menu {
        Picker(selection: $selection) {
            ForEach(Privacy.allCases) { value in
                Text(value.rawValue)
                    .tag(value)
            }
        } label: {}
    } label: {
        Text(selection.rawValue)
            .font(.largeTitle)
    }.id(selection)


