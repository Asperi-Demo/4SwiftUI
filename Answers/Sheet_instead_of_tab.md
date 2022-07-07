```
🔥BOYCOTT on russia - terrorist must be punished!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: SwiftUI tab view display sheet (by Oxford212)

A: I assume you wanted this (tested with Xcode 12 / iOS 14)

```
struct ContentView: View {
    @State var isPresenting = false
    @State private var selectedItem = 1
    @State private var oldSelectedItem = 1


    var body: some View {
        TabView(selection: $selectedItem){
            Text("1")
                .tabItem {
                        Image(systemName: "house")
                }.tag(1)

            Text("")    // I want this to display the sheet.
                .tabItem { Image(systemName: "plus.circle") }
                .tag(2)

            Text("3")
                .tabItem {
                    Image(systemName: "calendar")
                }.tag(3)
        }
     //   .onReceive(Just(selectedItem))  // SwiftUI 1.0 - import Combine for this
        .onChange(of: selectedItem) {    // SwiftUI 2.0 track changes
				if 2 == selectedItem {
                self.isPresenting = true
				} else {
					self.oldSelectedItem = $0
				}
			}
        .sheet(isPresented: $isPresenting, onDismiss: {
                self.selectedItem = self.oldSelectedItem
			}) {
            testSheet
        }
        .accentColor(Color.orange)


    }
    var testSheet : some View {
        VStack{
            Text("testing")
        }
    }
}
```
