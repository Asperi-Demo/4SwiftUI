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

![FU4ch2IWAAMR4Ev](https://user-images.githubusercontent.com/62171579/173038846-d2c2a632-cfb9-423b-9f42-3f669ef1ac03.png)


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
      Text("Boycott russia!").font(.title).background(.blue)
                .background(GeometryReader {
                    Color.clear.preference(key: SizePreferenceKey.self,
                        value: $0.frame(in: .local).size)
           })
      Text("Help To Stop WAR!").font(.headline).background(.yellow)
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
