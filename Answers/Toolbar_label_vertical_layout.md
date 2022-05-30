```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: SwiftUI 2.0 ToolbarItem Labels showing sideways (by Michel Donais)

A: The .toolbar modifier has its own default label styles, by using below method we'll be able to override 
the default label style. So, there is `LabelStyle` for this purpose and we could configure components of label as needed. 

Here is possible approach:

```
struct VerticalLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack(spacing: 0) {
            configuration.title
            configuration.icon
        }
    }
}
```

and now apply it to entire toolbar or to needed labels only


```
content.toolbar {
    ToolbarItem(placement: .bottomBar) {
        Button {
            menu.value = .file
        } label: {
            Label(LocalizedStringKey("menu.file"),
                systemImage: Symbol.SymbolEnum.sf_folder.systemName! )
                .labelStyle(VerticalLabelStyle())                        // << here !1
        }
    }
``` 
