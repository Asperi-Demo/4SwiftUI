```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: How to properly include "Add Item" button in a NavigationView using SwiftUI? (by electromaggot)

A: `NavigationLink` should be inside `NavigationView`, not in navigation bar, so the following approach works...

    @State private var addMode = false
    var body: some View {
        NavigationView {
            VStack {
                List(listItems) { listItem in
                    NavigationLink(destination: AddDetailView(existingItem: listItem)) {
                        Text(listItem.name)
                    }
                }
                .navigationBarTitle(Text("Configure List Items"), displayMode: .inline)
                .navigationBarItems(trailing: Button(action: { 
                     // button activates link
                      self.addMode = true 
                    } ) {
                    Image(systemName: "plus")
                        .resizable()
                        .padding(6)
                        .frame(width: 24, height: 24)
                        .background(Color.blue)
                        .clipShape(Circle())
                        .foregroundColor(.white)
                } )

                // invisible link inside NavigationView for add mode
                NavigationLink(destination: AddDetailView(existingItem: nil), 
                    isActive: $addMode) { EmptyView() }
            }
        }
    }

