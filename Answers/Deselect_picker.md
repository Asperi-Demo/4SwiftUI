```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: Deselecting item from a picker SwiftUI (by Johnas)

A: To deselect we need optional storage for picker value, so here is a demo of possible approach.

Tested with Xcode 12.1 / iOS 14.1

![QkV6F](https://user-images.githubusercontent.com/62171579/170646223-40425ef3-5745-43d6-9e37-423ac59bc473.gif)

```
struct ContentView: View {
  @State private var value: Int?
  var body: some View {
    NavigationView {
      Form {
        let selected = Binding(
          get: { self.value },
          set: { self.value = $0 == self.value ? nil : $0 }
        )
        Picker("Select", selection: selected) {
          ForEach(0...9, id: \.self) {
            Text("\($0)").tag(Optional($0))
          }
        }
      }
    }
  }
}
```
