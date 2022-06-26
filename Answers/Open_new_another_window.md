```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: SwiftUI 2: the way to open view in new window (by Andrew____Pls_Support_Ukraine)

A: ### Update: Xcode 14 / macOS 13

Now we can explicitly open needed window giving it identifier and use it in `openWindow` environment action.

```
class BookViewModel: ObservableObject {} 

class AppState: ObservableObject {
    @Published var selectedBook: BookViewModel?
}

@main
struct SwiftUI2_MacApp: App {
    @StateObject var appState = AppState()

    @SceneBuilder 
    var body: some Scene {
        WindowGroup {         // main scene
            ContentView()
              .environmentObject(appState)   // inject to update
                                             // selected book
        }

        Window("Book Viewer", id: "book") { // << here !!
            BookView(model: appState.selectedBook)
        }

        // also possible variant with injected model for group
        // WindowGroup("Book Viewer", id: "book", for: Book.self) {  book in // << here !!
        //   BookView(model: book)
        // }
    }
}

struct ContentView: View {
    @EnvironmentObject var appState: AppState

    @Environment(\.openWindow) private var openWindow   // << !!

    var body: some View {

        // assuming selection in grid somewhere here to
        // appState.selectedBook

        Button("Open Book") {
            openWindow(value: "book")       // << here !!

        // for group variant with injected value
        // if let book = self.selectedBook {
        //    openWindow(value: "book", book)       // << here !!
        // }
        }
    }
}
```
