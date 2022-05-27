```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: SwiftUI NavigationLink in LazyVGrid picking random index (by nishith Singh)

A: You activate all links at once (because all of them depends on one state). Instead we need to use different `NavigationLink` constructor for such cases.

Here is fixed variant. Tested with Xcode 12.1 / iOS 14.1

```
struct TestView: View {
    let columns = [
        GridItem(.flexible())
    ]
    @State var selectedItem: Int?

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(1...10, id: \.self) { index in
                    Text("\(index)")
                        .background(NavigationLink(destination: TestDetail(index: index), tag: index, selection: $selectedItem) {
                            EmptyView()
                        }).onTapGesture {
                            selectedItem = index
                        }
                }
            }
        }
    }
}
```
