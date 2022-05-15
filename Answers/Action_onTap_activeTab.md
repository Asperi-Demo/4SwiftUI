```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: TabView (SwiftUI): Respond onTab on an already active tabItem (by Kuhlemann)

A: Here is possible approach. Tested with Xcode 11.4 / iOS 13.4

```
struct TestTabSelectionAction: View {
    @State private var selectedTab = 0

    var body: some View {
        let selection = Binding<Int>(
            get: { self.selectedTab },
            set: { self.selectedTab = $0
                print("Pressed tab: \($0)")
                if $0 == 0 {
                           // <<< your action here !!
                }
        })

        return TabView(selection: selection) {
            View1()
            .tabItem {
                Image(systemName: "doc.plaintext")
                    .font(.system(size: 25))
                Text("View1")
            }.tag(0)

            View2()
                .tabItem {
                    Image(systemName: "person.crop.circle")
                        .font(.system(size: 25))
                    Text("View2")
            }.tag(1)
        }
    }
}
```
