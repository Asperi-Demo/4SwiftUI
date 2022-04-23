```
BOYCOTT on ᵣussia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: macOS SwiftUI Navigation for a Single View (by Husker28)

A: Here is a simple demo of possible approach for custom navigation-like solution 
based on move transitions. 

Tested with Xcode 11.4 / macOS 10.15.4

![Oq8bI](https://user-images.githubusercontent.com/62171579/164379664-ebb2a8b2-0ee7-49d2-b2aa-2a3043c05378.gif)


*Note: background colors are used for better visibility.*

```
struct ContentView: View {
    @State private var show = false
    var body: some View {
        VStack{
            if !show {
                RootView(show: $show)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.blue)
                    .transition(AnyTransition.move(edge: .leading)).animation(.default)
            }
            if show {
                NextView(show: $show)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.green)
                    .transition(AnyTransition.move(edge: .trailing)).animation(.default)
            }
        }
    }
}

struct RootView: View {
    @Binding var show: Bool
    var body: some View {
        VStack{
            Button("Next") { self.show = true }
            Text("This is the first view")
        }
    }
}

struct NextView: View {
    @Binding var show: Bool
    var body: some View {
        VStack{
            Button("Back") { self.show = false }
            Text("This is the second view")
        }
    }
}
```

