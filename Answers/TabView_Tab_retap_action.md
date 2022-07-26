```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: SwiftUI TabBar: Action for tapping TabItem of currently selected Tab to reset view (by matthias_code)

A: Here is possible solution - inject proxy binding around `TabView` selection state and handle repeated tab tapped before bound value set, like below.

Tested with Xcode 12.1 / iOS 14.1

```
struct ContentView: View {
  @State private var selection = 0
  
  var handler: Binding<Int> { Binding(
    get: { self.selection },
    set: {
      if $0 == self.selection {
        print("Reset here!!")
      }
      self.selection = $0
    }
  )}
  
  var body: some View {
    TabView(selection: handler) {
      Text("Tab 1")
        .tabItem {
          Image(systemName: "star")
          Text("One")
        }
        .tag(0)
      
      Text("Tab 2")
        .tabItem {
          Image(systemName: "star.fill")
        }
        .tag(1)
    }
  }
}
```
