```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: SwiftUI iOS 13.3 Missing Navigation Bar title when nested inside TabView (by Uttiṇṇa Chong Liang Ooi)

A: ### Update: Xcode 13.4 / iOS 15.5

A possible approach is to join navigation view title with tab view selection dynamically, like

![TAi59](https://user-images.githubusercontent.com/62171579/171352850-01747fe3-3c2e-4421-a0c9-93db7cb39fe6.png)
![nB4g3](https://user-images.githubusercontent.com/62171579/171352868-6cbc54f6-bfbb-4212-a938-1a5ca365982b.png)


```
struct ContentView: View {
	let tabs = ["Tab 1", "Tab 2"]   // can be in model

	@State private var selection: String

	init() {
		_selection = State(initialValue: tabs[0]) // initial tab
	}

    var body: some View {
        NavigationView {
            TabView(selection: $selection) {   // << here !!
                Text("Tab 1")
                    .tabItem {
                        Text("Tab 1")
                    }.tag(tabs[0])

                Text("Tab 2")
                    .tabItem {
                        Text("Tab 2")
                    }.tag(tabs[1])
            }
			.navigationBarTitle(selection)    // << here !!
        }
    }
}
```

### Original 

`TabBar` is designed to be a root view, so to achieve your needs the following approach can be used instead

    struct ContentView: View {
        var body: some View {
            TabView {
                NavigationView {
                    Text("Tab 1")
                        .navigationBarTitle("Tab 1")
                        .navigationBarHidden(false)
                }
                .tabItem {
                    Text("Tab 1")
                }
    
                NavigationView {
                    Text("Tab 2")
                        .navigationBarTitle("Tab 2")
                        .navigationBarHidden(false)
                }
                .tabItem {
                    Text("Tab 2")
                }
                .navigationBarTitle("Tab 2")
                .navigationBarHidden(false)
            }
        }
    }
