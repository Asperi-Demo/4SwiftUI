```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: How to change "Cancel" button text in modal sheet view in SwiftUI on watchOS 7?

A: This Cancel is actually a navigation bar item. You can replace it with own button using toolbar, like


```
struct ContentView: View {
    @State private var showingModalView = false

    var body: some View {
        Button(action: {
            self.showingModalView.toggle()
        }) {
            Text("Show Modal View")
        }.sheet(isPresented: $showingModalView) {
            ModalView()
			.toolbar(content: {
				ToolbarItem(placement: .cancellationAction) {
					Button("Close") { self.showingModalView = false }
				}
			})

        }
    }
}
```

also you can hide it at all (and make your custom approach to close, eg. with button in sheet view, etc.)

        }.sheet(isPresented: $showingModalView) {
            ModalView()
			.navigationBarHidden(true)

