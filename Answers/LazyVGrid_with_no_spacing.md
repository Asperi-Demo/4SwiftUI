```
BOYCOTT on ᵣussia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: SwiftUI configure LazyVGrid with no spacing (by randomor)

A: You give `spacing: 0` in `LazyVGrid` for vertical spacing, and `spacing: 0` in `GridItem` for horizontal spacing.

Here is a demo. Tested with Xcode 12 / iOS 14

![yWmPD](https://user-images.githubusercontent.com/62171579/162632696-9cae9a9d-2215-4219-9c36-2e5b4e787522.png)


```
struct TestImagesInGrid: View {
    @State private var imageNames: [String]

    private let threeColumnGrid = [
        GridItem(.flexible(minimum: 40), spacing: 0),
        GridItem(.flexible(minimum: 40), spacing: 0),
        GridItem(.flexible(minimum: 40), spacing: 0),
    ]

    init() {
        _imageNames = State(initialValue: (0..<8).map { _ in
            "image_\(Int.random(in: 1...3))"
        })
    }

    var body: some View {
        LazyVGrid(columns: threeColumnGrid, alignment: .leading, spacing: 0) {
            ForEach(imageNames.indices) { i in
                Image(imageNames[i]).resizable()
                    .aspectRatio(1, contentMode: .fill)
                    .border(Color.black)
            }
        }
    }
}
```


  [1]: https://i.stack.imgur.com/yWmPD.png
