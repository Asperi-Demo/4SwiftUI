```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: Change color of unselected icon in TabView (SwiftUI) (by alexbayker)

A: You can use `TabBarAccessor` from my solution to
[Programmatically detect Tab Bar or TabView height in SwiftUI](https://github.com/Asperi-Demo/4SwiftUI/blob/master/Answers/Find_TabBar_height.md) 
to change what you need as in below demo.

Tested with Xcode 11.4 / iOS 13.4

![0izcv](https://user-images.githubusercontent.com/62171579/168857841-c514c7d4-d10e-4baf-adba-ec8cb4dddf63.png)

    TabView {
        Text("First View")
            .background(TabBarAccessor { tabBar in
                tabBar.unselectedItemTintColor = UIColor.red
            })
            .tabItem { Image(systemName: "1.circle") }
            .tag(0)
        Text("Second View")
            .tabItem { Image(systemName: "2.circle") }
            .tag(1)
    }

**Update:** alternate via appearance also works

![4LpVq](https://user-images.githubusercontent.com/62171579/168857757-4e895de1-a19d-4647-8dab-13a09a1b3c85.png)


    init() {
        UITabBar.appearance().unselectedItemTintColor = UIColor.green
    }
