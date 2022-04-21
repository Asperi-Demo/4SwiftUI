```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: How to detect keyboard events in SwiftUI on macOS? (by )

A: Here is just a demo of a possible approach, backward compatible with SwiftUI1.0+, and 
allows more control over events handling. 

Tested with Xcode 11.4 / macOS 10.15.4

```
struct KeyEventHandling: NSViewRepresentable {
    class KeyView: NSView {
        override var acceptsFirstResponder: Bool { true }
        override func keyDown(with event: NSEvent) {
            print(">> key \(event.charactersIgnoringModifiers ?? "")")
        }
    }

    func makeNSView(context: Context) -> NSView {
        let view = KeyView()
        DispatchQueue.main.async { // wait till next event cycle
            view.window?.makeFirstResponder(view)
        }
        return view
    }

    func updateNSView(_ nsView: NSView, context: Context) {
    }
}

struct TestKeyboardEventHandling: View {
    var body: some View {
        Text("Hello, World!")
            .background(KeyEventHandling())
    }
}
```

Output:

![5mGL4](https://user-images.githubusercontent.com/62171579/164449827-68d4e96b-c723-4c8a-8efa-e9897a2f650c.png)

