```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: Nested TabView - Remove inner tab bar iOS 13, Swift UI (by McGuile)

A: Hide it explicitly... as it is for backward compatibility it is safe, because behavior is already known and won't change.

So here is a solution

    var body: some View {
        TabView(selection: $outerTabViewSelectedTab,
                content:  {
                    Text("Outer 1").tabItem { Text("Outer 1") }.tag(1)
                    TabView(selection: $innerTabViewSelectedTab,
                            content:  {
                                Text("Inner 1").tag(1)
                 .background(TabBarAccessor { tabBar in
                  tabBar.isHidden = true
                 })
                                Text("Inner 2").tag(2)
                            }).tabItem { Text("Outer 2") }.tag(2)
                })
    }


Used `TabBarAccessor` from my other solution in https://github.com/Asperi-Demo/4SwiftUI/blob/master/Answers/Find_TabBar_height.md
