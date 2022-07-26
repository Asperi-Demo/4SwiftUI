```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: SwiftUI Dynamic Image Sizing (by impression7vx)

A: The possible solution is to use screen bounds (which will be different for different phones) as reference value to calculate per-cent-based dynamic size for image. And to track device orientation changes we wrap our calculations into `GeometryReader`.

Note: I don't have your images, so added white borders for demo purpose

![WQ9HA](https://user-images.githubusercontent.com/62171579/174344153-84605728-c3d6-46ab-86a4-8237920d68fc.png)

```
struct ClickableImageAndText: View {
	let image: String
	let text: String
	let tapAction: (() -> Void)

	@State private var size = CGFloat(32) // some minimal initial value (not 0)

	var body: some View {
		VStack {
			Image(image)
				.resizable()
				.scaledToFit()
				// .border(Color.white)            // << for demo !!
				.background(GeometryReader { _ in
					// GeometryReader is needed to track orientation changes
					let sizeX = UIScreen.main.bounds.width
					let sizeY = UIScreen.main.bounds.height

					// Screen bounds is needed for reference dimentions, and use
					// it to calculate needed size as per-cent to be dynamic
					let width = min(sizeX, sizeY)
					Color.clear                             // % (whichever you want)
						.preference(key: ViewWidthKey.self, value: width * 0.2) 
				})
				.onPreferenceChange(ViewWidthKey.self) {
					self.size = max($0, size)
				}
				.frame(width: size, height: size)

			Text(text)
				.foregroundColor(.white)
		}
		.contentShape(Rectangle())
		.onTapGesture {
			tapAction()
		}
	}
}
```
