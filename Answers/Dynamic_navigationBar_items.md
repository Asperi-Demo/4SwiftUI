```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: Dynamically set SwiftUI NavigationBarItems? (by Brandogs)

A: Here is a demo of possible solution - add tracking selection for tabs and make button depending of tab selection. Tested with Xcode 12 / iOS 14

```
struct DemoView: View {
  @State private var selection = 0    // << here !!
  var body: some View {
    NavigationView {
      TabView(selection: $selection) {
        contentWithNavigationButtons()
          .tabItem {
            Image(systemName: "house")
            Text("Buttons")
          }.tag(0)                // << here !!
        
        contentWithoutNavigationButtons()
          .tabItem {
            Image(systemName: "person")
            Text("No Buttons")
          }.tag(1)
        
      }
      .navigationBarItems(trailing: Group {
        if selection == 0 {     // << here !!
          Button("Some"){}
        }
      })
    }
  }
}
```
