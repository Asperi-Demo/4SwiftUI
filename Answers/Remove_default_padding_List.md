```
BOYCOTT on ᵣussia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: Remove default padding from List in SwiftUI (by eja08)

A: To achieve this we need to use `ForEach` inside `List` combined with `.listRowInsets` as in example below

![oYG60](https://user-images.githubusercontent.com/62171579/164958591-9e3bf2c9-078d-4fc7-9a76-74dc385f0749.png)

```
struct Demo: View {
    var colors: [Color] = [.red, .blue, .yellow]
    var body: some View {
        List {
            ForEach(colors, id: \.self) { color in
                color
            }.listRowInsets(EdgeInsets())
        }
        // Update: Different iOS versions have different 
        // default List styles, so set explicit one if needed
        .listStyle(PlainListStyle())
    }
}
```
