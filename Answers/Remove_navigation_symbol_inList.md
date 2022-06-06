```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: How to delete Navigation Link > symbol in SwiftUI?

A: Chevron image of link is injected by `List` for automatically detected `NavigationLink`. This is default behavior of `List`. 

The possible solution is to replace `NavigationLink` inside `List` with `Button` and activate `NavigationLink` programmatically.

Here is a demo of approach. Tested with Xcode 12.4 / iOS 14.4

![VYWWt](https://user-images.githubusercontent.com/62171579/172154647-93104649-fd19-4456-9e94-78b5eb43cb28.gif)

```
struct Message: Identifiable, Hashable {
  let id: String
}

struct ContentView: View {
  let messages = [Message(id: "1"), Message(id: "2"), Message(id: "3")]
  @State private var tappedItem: Message?

  var body: some View {
    NavigationView{
      List{
        ForEach(messages) { item in
          Button(action: { tappedItem = item }) {   // << activate !!
            Text("Message \(item.id)")
              .padding(.vertical,3)
          }
        }
      }
      .background(
        NavigationLink(destination: Text("MessageDetailView \(tappedItem?.id ?? "")"),
          isActive: Binding(
            get: { tappedItem != nil },         // << handle !!
            set: { _,_ in tappedItem = nil }
          )){
          EmptyView()
        }
      )
    }
  }
}
```
