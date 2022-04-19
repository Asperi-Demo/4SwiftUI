```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: Sheet inside ForEach doesn't loop over items SwiftUI (by xmetal)

A: There should be only one sheet, so here is possible approach - use another sheet modifier and activate it by selection

Tested with Xcode 12 / iOS 14 (iOS 13 compatible)

```
extension Int: Identifiable {     // just for demo
    public var id: Int { self }
}

struct ContentView: View {
    @State private var selectedMovie: Int? = nil   // << unique selection

    var movies = ["Harry potter", "Mad Max", "Oblivion", "Memento"]
    var body: some View {
        NavigationView {
            List {
                ForEach(0 ..< movies.count) { movie in
                    HStack {
                        Text(self.movies[movie])
                        Image(systemName: "heart")
                    }
                        .onTapGesture {
                            self.selectedMovie = movie
                    }
                }
            }
            .sheet(item: self.$selectedMovie) {  // << here !!
                Text(self.movies[$0])    // selection injected dynamically
            }
        }
    }
}
```
