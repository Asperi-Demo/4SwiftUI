```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: When do I need to implement the contents of `reduce`? (by shingo.nakanishi)

A: The `reduce` is needed to process preference values for sibling views (ie. same preference key is used by views in one same level of container, so it is called one after another and it is needed to decide what to do - `reduce` gives us a chance for that).

Here is an example (based on your preference key) of how to calculate common size of sibling views. If you remove content of `reduce` only first call preference value will be used (by design)

Demo is prepared with Xcode 13 / iOS 15

![pMaOx](https://user-images.githubusercontent.com/62171579/173037172-519d5cea-aca9-44c7-9a2a-ab4814ed10cb.png)

```
extension CGSize {
  static func +=(lhs: inout CGSize, rhs: CGSize) {
    lhs.width += rhs.width
    lhs.height += rhs.height
  }
}

struct SizePreferenceKey: PreferenceKey {
  typealias Value = CGSize
  static var defaultValue: Value = .zero

  static func reduce(value: inout Value, nextValue: () -> Value) {
    value += nextValue()
  }
}

struct TestPrefReduce: View {
  @State private var size: CGSize = .zero

  var body: some View {
    VStack {
      Text("Common size: [\(Int(size.width)) x \(Int(size.height))]")
      Divider()
      Text("Title").font(.title)
                .background(GeometryReader {
                    Color.clear.preference(key: SizePreferenceKey.self,
                        value: $0.frame(in: .local).size)
           })
      Text("Hello, World!").font(.headline)
                .background(GeometryReader {
                    Color.clear.preference(key: SizePreferenceKey.self,
                        value: $0.frame(in: .local).size)
           })
    }
    .onPreferenceChange(SizePreferenceKey.self) {
        self.size = $0
    }
  }
}
```
