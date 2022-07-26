```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: SwiftUI EditButton in HStack not activating edit mode (by dankito)

A: Here is working solution - looks like they require that EditButton was a root view of section, so we can construct everything else above it. (tested with Xcode 11.4 / iOS 13.4)

*Note: `@Environment(\.editMode) var editMode` is not needed*

![mJjbJ](https://user-images.githubusercontent.com/62171579/170994818-7fc1b02b-c08a-4232-9616-5fbd3f5e45ee.png)

    Section(header:
        EditButton().frame(maxWidth: .infinity, alignment: .trailing)
            .overlay(Text("Header"), alignment: .leading)
    )
    {
        ForEach(items, id: \.self) { item in
            Text(item)
        }
        .onMove(perform: reorderItems)
        .onDelete(perform: deleteItems)
    }
