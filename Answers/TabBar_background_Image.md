```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: I want to set a background to the TabBar (by Horitsu Potter)

<img width="1110" alt="73BAZ" src="https://user-images.githubusercontent.com/62171579/173079861-3a5bc095-bd4b-42d7-930e-495e34a3c981.png">

A: Assuming you have right image in your assets catalog (or prepared in advance), you can set it in view's init, like

```
struct ContentView: View {
	init() {
		let appearance = UITabBarAppearance()
  		appearance.configureWithOpaqueBackground()
    	appearance.backgroundImage = UIImage(named: "image")
		UITabBar.appearance().scrollEdgeAppearance = appearance
    }

   // ... other code
}
```
