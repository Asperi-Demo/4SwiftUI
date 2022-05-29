```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: Passing data from simple NSView to SwiftUI View (by andrewhoff)

A: Here is a solution (with some replicated parts). Tested with Xcode 11.4 / macOS 10.15.4

```
class KeyboardInput: ObservableObject {
    @Published var keyCode: UInt16 = 0
}

struct KeyboardEvent: NSViewRepresentable {
    @Binding var keyStorage: UInt16          // << here !!
    init(into storage: Binding<UInt16>) {
        _keyStorage = storage
    }

    class KeyView: NSView {
        var owner: KeyboardEvent?   // << view holder

        override var acceptsFirstResponder: Bool { true }
        override func keyDown(with event: NSEvent) {
            print("\(event.keyCode)")
            owner?.keyStorage = event.keyCode
        }
    }

    func makeNSView(context: Context) -> NSView {
        let view = KeyView()
        view.owner = self           // << inject
        DispatchQueue.main.async {
            view.window?.makeFirstResponder(view)
        }
        return view
    }

    func updateNSView(_ nsView: NSView, context: Context) {
    }

}

struct ContentView: View {
    @EnvironmentObject var input: KeyboardInput     // save the keyCode here
    var body: some View {
        VStack {
            Text("Code: \(input.keyCode)")
            KeyboardEvent(into: $input.keyCode) // << binding !!!
        }
    }
}
```
