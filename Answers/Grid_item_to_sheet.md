```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: How do I correctly pass a "cell item" to a .sheet from a SwiftUI LazyVGrid? (by Rillieux)

A: In such use-case it is more appropriate to use variant of sheet constructed with item, because sheet must be moved out of dynamic content (otherwise you create as many sheets as items in ForEach).

Here is possible solution. Tested with Xcode 12 / iOS 14.

```
// helper extension because .sheet(item:...) requires item to be Identifiable
extension String: Identifiable {
    public var id: String { self }
}

struct GridView: View {

    @State private var selected: String? = nil

    let data = (1...755).map { "\($0)" }
    let columns: [GridItem] = Array(repeating: .init(.flexible(), spacing: gridSpacing), count: columnCount)
    let colCount: CGFloat = CGFloat(columnCount)
    var body: some View {
        GeometryReader { geo in
            ScrollView (showsIndicators: false) {
                LazyVGrid(columns: columns, spacing: gridSpacing) {
                    ForEach(data, id: \.self) { item in

                        Button(action: {
                            selected = item      // store selected item
                        }) {
                            GridCell(item: item, size: (geo.size.width - (colCount * gridSpacing)) / colCount)
                        }
                    }
                }
            }.sheet(item: $selected) { item in     // activated on selected item
                DetailView(item: item)
            }
            .padding(.horizontal, gridSpacing)
        }
    }
}
```
