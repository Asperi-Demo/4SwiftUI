```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: How to change "Cancel" button text in modal sheet view in SwiftUI on watchOS 7?

A: This `Cancel` is actually a navigation bar item. We can replace it with own button using toolbar, like

![TPEyP](https://user-images.githubusercontent.com/62171579/166915270-d33d301a-9b70-49c0-b722-6204f94d3e5f.png)

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

also we can hide it at all (and make our custom approach to close, eg. with button in sheet view, etc.)

        }.sheet(isPresented: $showingModalView) {
            ModalView()
      .navigationBarHidden(true)

