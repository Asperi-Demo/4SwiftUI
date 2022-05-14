```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: Why does a SwiftUI TextField inside a navigation bar only accept input one character at a time? (by Mozahler)

A: The problem is in rebuilt `NavigationView` completely that result in dropped text field focus.

Here is working approach. Tested with Xcode 11.4 / iOS 13.4

The idea is to avoid rebuild `NavigationView` based on knowledge that SwiftUI engine updates *only* modified views, so using decomposition we make modifications local and transfer desired values only between subviews directly not affecting top `NavigationView`, as a result the last kept stand.

![aY0fA](https://user-images.githubusercontent.com/62171579/168410556-6fcf5f6a-15b4-468d-8226-342b33b203e6.gif)

```
class QueryModel: ObservableObject {
    @Published var query: String = ""
}

struct ContentView: View {
    // No QueryModel environment object here - 
    //                implicitly passed down. !!! MUST !!!

    var body: some View {
        NavigationView {
            ResultsView()
                .navigationBarTitle(Text("Library"))
                .navigationBarItems(trailing: SearchItem())
        }
    }
}

struct ResultsView: View {
    @EnvironmentObject var qm: QueryModel // << injected here from top
    var body: some View {
        VStack {
            Text("Search: \(qm.query)") // receive query string
        }
    }
}

struct SearchItem: View {
    @EnvironmentObject var qm: QueryModel // << injected here from top
    @State private var query = "" // updates only local view

    var body: some View {
        let text = Binding(get: { self.query }, set: {
            self.query = $0; self.qm.query = $0;       // transfer query string
        })
        return TextField("search", text: text)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(QueryModel())
    }
}
```
