```
BOYCOTT on ᵣussia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: SwiftUI ToolbarItem doesn't present a View from a NavigationLink (by javierdemartin)

A: `NavigationLink` should be *inside* `NavigationView`. Toolbar is not in `NavigationView`, 
thus a possible solution is to put button in toolbar and activate `NavigationLink` inside
`NavigationView` programmatically.

So assuming you have somewhere in parent

```
NavigationView {
   MyView()
}
```

here is a solution:

```
struct MyView: View {
  
  @ObservedObject var viewModel = MyViewModel()
  @State private var showNew = false

  var body: some View {
    List(viewModel.data, id: \.name) { data in
      NavigationLink(destination: MyDetailView(data: data.name)) {
        Text(data.name)
      }
    }
    .listStyle(InsetGroupedListStyle())
    .background(
        NavigationLink(destination: MyDetailView(), isActive: $showNew) {
          EmptyView()
        }
    )
    .edgesIgnoringSafeArea(.all)
    .toolbar {
      ToolbarItem(placement: .navigationBarTrailing) {  
        Button("New Element") {
            self.showNew = true
        }
      }
    }
  }
}
```
