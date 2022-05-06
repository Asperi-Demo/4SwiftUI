```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: TabView with "PageTabViewStyle" does not update it's content when @State var changes (by Sebastian Boldt)

A: `TabView` expects to have container of pages, but you included only one `HStack` (with own dynamic content), moreover chaining number of pages you have to reset tab view, so here is a fix.

Tested with Xcode 12 / iOS 14

![8DMZe](https://user-images.githubusercontent.com/62171579/167065309-2510b77d-61fc-4fb9-a760-89239f6a1b09.gif)

```
struct ContentView: View {
    @State var numberOfPages: Int = 0

    var body: some View {
        VStack {
            Text("Tap Me").onTapGesture(count: 1, perform: {
                self.numberOfPages = [2,5,10,15].randomElement()!
            })
            if self.numberOfPages != 0 {
                TabView {
                    ForEach(0..<numberOfPages, id: \.self) { index in
                        Text("\(index)").frame(width: 300).background(Color.red)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                .frame(height: 300)
                .id(numberOfPages)          // << here !!
            }
        }
    }
}
```
