```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: Programmatically detect Tab Bar or TabView height in SwiftUI (by eResourcesInc)

A: As bridge to UIKit is officially allowed and documented, it is possible to read needed information from there when needed.

Here is possible approach to read tab bar height directly from `UITabBar`


    // Helper bridge to UIViewController to access enclosing UITabBarController
    // and thus its UITabBar
    struct TabBarAccessor: UIViewControllerRepresentable {
        var callback: (UITabBar) -> Void
        private let proxyController = ViewController()
    
        func makeUIViewController(context: UIViewControllerRepresentableContext<TabBarAccessor>) ->
                                  UIViewController {
            proxyController.callback = callback
            return proxyController
        }
        
        func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<TabBarAccessor>) {
        }
        
        typealias UIViewControllerType = UIViewController
    
        private class ViewController: UIViewController {
            var callback: (UITabBar) -> Void = { _ in }
    
            override func viewWillAppear(_ animated: Bool) {
                super.viewWillAppear(animated)
                if let tabBar = self.tabBarController {
                    self.callback(tabBar.tabBar)
                }
            }
        }
    }
    
    // Demo SwiftUI view of usage
    struct TestTabBar: View {
        var body: some View {
            TabView {
                Text("First View")
                    .background(TabBarAccessor { tabBar in
                        print(">> TabBar height: \(tabBar.bounds.height)")
                        // !! use as needed, in calculations, @State, etc.
                    })
                    .tabItem { Image(systemName: "1.circle") }
                    .tag(0)
                Text("Second View")
                    .tabItem { Image(systemName: "2.circle") }
                    .tag(1)
            }
        }
    }

