```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: How we can Lazy load data to a Form/List in SwiftUI?

A: The problem is that static data source (and all internal dependencies) are allocated at once, even if later the corresponding UI rows will be shown only when needed.

Here is possible approach to solve this scenario - to make data container dynamic and load data by blocks (taking into account that List/Form reuses rows)

Tested with Xcode 12 / iOS 14

```
struct ContentView: View {
  let max = 1000000 // even Int.max, if you want
  let block = 10

  @State private var indices = [0]   // << initially loaded small part

  var body: some View {
    List {
      ForEach(indices, id: \.self) { index in
        Text("Row \(index)")
          .onAppear {

            // load next block when last row shown (or can be 
            // tuned to preload in avance)

            if indices.last == index && index < max {
              let next = max - index
              indices.append(contentsOf:
                Array(index + 1..<index+(next > block ? block : next)))
            }
          }
      }
    }
  }
}
``` 
