```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: How do I make all views the same height in a SwiftUI View with an HStack? (by Mozahler)

A: Here is possible (seems simplest) approach. Tested with Xcode 12 / iOS 14

![eld5L](https://user-images.githubusercontent.com/62171579/173306295-fc6c2d84-af2f-45b7-b060-e73f6ed5761b.png)

```
struct DemoView: View {
	var dataSource = [1, 0, 34, 12, 59, 44]

	var body: some View {
		HStack(alignment: .top) {
			Spacer()
			/// i want these to all be the same height
			ForEach(0 ..< 6) { index in
				VStack {
					Text("\(index)")
					Color.clear
						.frame(width: 20, height: CGFloat(dataSource.max() ?? 0))
						.overlay(
							Color.orange
								.frame(height: CGFloat(self.dataSource[index]))
						, alignment: .top)
					Text("\(dataSource[index])")
				}
			}
			Spacer()
		}
	}
}
```
