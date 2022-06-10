```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: SwiftUI navigation titles within TabView (by John Sorensen)

A: We can define title depending on tab selection. Below is a simple demo of approach. Tested with Xcode 13 / iOS 15

```
struct ContentView: View {
    @State var selection = 1

    var body: some View {
        NavigationView {
            TabView(selection: $selection) {
                Text("Hello")
                    .tabItem {
                        Image(systemName: "square.stack")
                }.tag(1)
                Text("Hello Again")
                    .tabItem {
                        Image(systemName: "checkmark.square")
                }.tag(2)
            }
            .navigationTitle(selection == 1 ? "First" : "Second") // << here !!
        }
    }
}
```
