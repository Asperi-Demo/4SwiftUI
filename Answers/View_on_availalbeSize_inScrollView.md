```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: SwiftUI - making view within VStack fill available space in ScrollView (by DevB1)

A: We need to calculate that manually, because ScrollView requires finite intrinsic content size.

Here is a possible approach. Tested with Xcode 13.4 / iOS 15.5

![Otrh2](https://user-images.githubusercontent.com/62171579/171802569-67caf099-56b8-4623-85b9-ec1407daafc4.png)


	GeometryReader { gp in
		ScrollView(.vertical, showsIndicators: false) {
			VStack(alignment: .leading) {

				Text("Selector")
					.background(Color.yellow)

				Text("Browse")
					.frame(minHeight: height, alignment: .top)
					.background(GeometryReader {
						Color.clear.preference(key: ViewOffsetKey.self,
							value: $0.frame(in: .named("parent")).origin.y)
					})
					.background(Color.green)
			}
			.navigationBarHidden(true)
		}
		.coordinateSpace(name: "parent")
		.onPreferenceChange(ViewOffsetKey.self) {
			height = gp.size.height - $0
		}
		.frame(maxWidth: .infinity)
	}

