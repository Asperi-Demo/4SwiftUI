```
🔥BOYCOTT on russia - terrorist must be punished!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: SwiftUI: TabView dynamic accentColor (by Jim)

A: To update tab items `TabView` should be rebuilt, so try


Here is a full demo (colors changed for better visibility). Tested with Xcode 13 / iOS 15

![iMXmL](https://user-images.githubusercontent.com/62171579/177005121-6ba3ce79-9951-43c8-9089-6a9aa21445d6.gif)

```
struct DemoView: View {
	@State private var selection = 0

	var body: some View {
		TabView(selection: $selection) {
			Text("FirstTabView")
				.tabItem {
					Image(systemName: "1.circle").renderingMode(.template)
				}.tag(0)
			Text("SecondTabView")
				.tabItem {
					Image(systemName: "2.circle").renderingMode(.template)
				}.tag(1)
		}
		.accentColor(selection == 0 ? .red : .blue)
		.id(selection)                        // << here !!

	}
}
```
