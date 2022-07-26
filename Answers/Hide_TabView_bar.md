```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: Hide SwiftUI TabView bar inside NavigationLink views (by pawello2222)

A: The possible workaround solution can be based on `TabBarAccessor` from my answer on [Programmatically detect Tab Bar or TabView height in SwiftUI](https://github.com/Asperi-Demo/4SwiftUI/blob/master/Answers/Find_TabBar_height.md)

Here is a required modification in tab item holding `NavigationView`. Tested with Xcode 11.4 / iOS 13.4

![tHgRC-2](https://user-images.githubusercontent.com/62171579/168462054-e50d89b4-827d-4e11-981c-d17fa5d02e7a.gif)

```
struct FirstTabView: View {
    @State private var tabBar: UITabBar! = nil

    var body: some View {
        NavigationView {
            NavigationLink(destination:
                FirstChildView()
                    .onAppear { self.tabBar.isHidden = true }     // !!
                    .onDisappear { self.tabBar.isHidden = false } // !!
            ) {
                Text("Go to...")
            }
            .navigationBarTitle("FirstTitle", displayMode: .inline)
        }
        .background(TabBarAccessor { tabbar in   // << here !!
            self.tabBar = tabbar
        })
    }
}
```

*Note: or course if `FirstTabView` should be reusable and can be instantiated standalone, then `tabBar` property inside should be made optional and handle ansbsent tabBar explicitly.*
