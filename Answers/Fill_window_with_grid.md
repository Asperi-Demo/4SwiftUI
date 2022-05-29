```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: SwiftUI: How to create LazyGrid with equal number of rows and columns? (by Pondorasti)

A: Try the following (tested with Xcode 12b3 / iOS 14, no big-sur)

```
struct TestGridFitView: View {
    let columns = Array(repeating: GridItem(.flexible(minimum: 32), spacing: 0), count: 10)
    var body: some View {
        LazyVGrid(columns: columns, spacing: 0) {
            ForEach(1...100, id: \.self) { item in
                Rectangle().fill(Color.clear)
                    .aspectRatio(1, contentMode: .fit)
                    .border(Color.black)
            }
        }
        .background(Color.red)
        .aspectRatio(contentMode: .fit)
        
    }
}
```
