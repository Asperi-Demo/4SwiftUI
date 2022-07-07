```
🔥BOYCOTT on russia - terrorist must be punished!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: SwiftUI: Can I add more Views to TabView then Tab Items? (by Michał Ziobro)

A: I hope the following approach would be useful. The idea is to have dynamic range which shows tab items depending on currently selected one. 

For this demo selection, and including visible tabs, are changed depending on preview/next button, but it is not important - the of selection might be different, it just need update range of visible tabs depending on selected tab. That is it.

Here is how the demo behaves:

![ezgif com-gif-maker-61](https://user-images.githubusercontent.com/62171579/177846787-1149c159-bcde-414e-ad63-0c8578b9cc97.gif)

    struct ContentView: View {
        static let maxTabs = 8
        
        @State var selectedTab = 2
        @State var visibleTabs = [0, 1, 2, 3]
        var body: some View {
            VStack {
                self.selectorView
                Divider()
                TabView(selection: $selectedTab) {
                    ForEach(visibleTabs, id: \.self) { i in
                        self.viewForTab(i)
                            .tabItem {
                                Image(systemName: "\(i).circle")
                                Text("Item \(i)")
                            }.tag(i)
                    }
                }
            }
        }
        
        var selectorView: some View {
            HStack {
                Button(action: {
                    let prev = self.selectedTab - 1
                    if prev >= 0 {
                        if prev < self.visibleTabs.min()! {
                            self.visibleTabs = self.visibleTabs.map { $0 - 1 }
                        }
                        self.selectedTab = prev
                    }
                }) {
                    Text("< Prev").padding([.top, .horizontal])
                }.disabled(self.selectedTab == 0)
                Button(action: {
                    let next = self.selectedTab + 1
                    if next < Self.maxTabs {
                        if next > self.visibleTabs.max()! {
                            self.visibleTabs = self.visibleTabs.map { $0 + 1 }
                        }
                        self.selectedTab = next
                    }
                }) {
                    Text("Next >").padding([.top, .horizontal])
                }.disabled(self.selectedTab == Self.maxTabs - 1)
            }
        }
        
        private func viewForTab(_ tag: Int) -> some View {
            // Provide your view for requested tab tag
            Text("Hello World \(tag)")
        }
    }
