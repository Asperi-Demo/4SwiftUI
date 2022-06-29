Q: Can you animate a SwiftUI View on disappear? (by James Allardice)

A: Probably you wanted transition, something like

![utMgj](https://user-images.githubusercontent.com/62171579/176427162-aa70c290-79d6-4716-a390-da0590459e23.gif)

**Update:** re-tested with Xcode 13.4 / iOS 15.5

```
struct Survey: View {
	@State private var id = 0

	var body: some View {
		VStack {
			MyText(text: "\(id)")

			Button("Increment") {
				self.id += 1
			}
		}
	}

	struct MyText: View {
		var text: String


		var body: some View {
			Text("\(text)").id(text)
				.frame(maxWidth: .infinity)
				.transition(.slide)
				.animation(.easeInOut(duration: 2), value: text)
		}
	}
}
```
