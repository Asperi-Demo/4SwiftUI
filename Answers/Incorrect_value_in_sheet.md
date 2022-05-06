```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: Sheet cannot show correct values in first time (by omusubi)

A: The `.sheet(isPresented:)` modifier captures content and does not update it even
if state (or any other dynamic property) is used inside. For correct work in such cases
(most usually in List/ForEach) it should be used `.sheet(item:)` instead. 

Here is a demo code.
Verified with Xcode 12.1 / iOS 14.1

```
struct ContentView: View {
    @State var selected: String?
    var body: some View {
        NavigationView {
            List(fruits, id: \.self) { fruit in
                Button(action: {
                    selected = fruit
                }) {
                    Text(fruit)
                }
            }
        }
        .sheet(item: $selected, content: { item in
            Text(item)
        })
    }
}

extension String: Identifiable {
    public var id: String { self }
}
```
