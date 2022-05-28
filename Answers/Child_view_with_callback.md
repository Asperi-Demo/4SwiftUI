```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: SwiftUI How to pass data from child to parent as done in C# with the 'Delegate-EventHandler-EventArgs' way (by Roland Schmidt)

A: Here is possible solution. Tested with Xcode 11.4 / iOS 13.4

```
struct ChildView: View {
    var function: (String) -> Void

    @State private var value = "Child Value"
    var body: some View {
        Button(action: {
            self.function(self.value)
        }, label: {
            Text("Button")
        })
    }
}

struct ContentView: View {
    var body: some View {
        ChildView { self.setViewBackToNil(myStringParameter: $0) }
    }

    func setViewBackToNil(myStringParameter: String) {
        print("I am the parent: \(myStringParameter)")
    }
}
```
