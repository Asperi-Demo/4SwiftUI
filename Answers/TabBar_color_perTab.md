```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: Change Tabview color based on which tab is selected -Swiftui (by Kenji)

A: Any `.appearance` affects instances created _after_ the appearance itself. So the solution is to _re-create_ `TabView` after appearance configuration changed.

Here is a demo of approach. Tested with Xcode 12 / iOS 14.

![nxsZC](https://user-images.githubusercontent.com/62171579/171011768-20f93649-a688-4947-a27e-eac09f467afe.gif)

```
struct DemoView: View {

    let tabBar = UITabBar.appearance()

    init() {
        tabBar.barTintColor = UIColor.red
    }

    @State private var selectedTab = 0    // preserves selected tab

    var body: some View {
        TabView(selection: $selectedTab) {
            Text("FirstView")
                .tabItem{
                    Text("First")
                }.tag(0)
            Text("SecondView")
                .tabItem{
                    Text("Second")
                }.tag(1)
        }
        .onAppear {
            setTabViewBackground()  // called, because `id` is below
        }
        .id(selectedTab)   // recreates entire above view with new tabbar
    }

    func setTabViewBackground() {
        tabBar.barTintColor = selectedTab != 0 ? .blue : .red
    }
}
```
