```
🔥BOYCOTT on russia - terrorist must be punished!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: SwuiftUI collapse multiline Text (by Nuno Gonçalves)

A: The problem of collaplisng `VStack` with several multi-line `Text` views is that we 
usually need to animate a frame between `nil` (none, infinity) and `0`, but to internal `Text` views 
only edge values are transferred.

To solve this it should be done two steps: 
1) make height animatable data, so every change to height value passed to content
2) calculate real max height of text content, because we need concrete values of animatable range.

So here is a demo of approach. Prepared with Xcode 13 / iOS 15

*Note: slow animation is activated in Simulator for better visibility*

![ezgif com-gif-maker-80](https://user-images.githubusercontent.com/62171579/180612675-51b2c28c-3b8a-45ad-994b-1fbc9d02a305.gif)

```
let bigText = """
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
"""

struct ContentView: View {

    // we need `true` on construction (not visible) to calculate
    // max content height
	@State var expanded = true    // << required initial true !!

	@State private var maxHeight: CGFloat?

	var body: some View {
		VStack(spacing: 20) {
			HStack {
				Button(expanded ? "Colapse" : "Expand") {
					withAnimation {
						self.expanded.toggle()
					}
				}
			}
			VStack(spacing: 10) {
				Text(bigText)
				Text(bigText)
			}
			.background(GeometryReader { // read content height
				Color.clear.preference(key: ViewHeightKey.self,
											  value: $0.frame(in: .local).size.height)
			})
			.onPreferenceChange(ViewHeightKey.self) {
				if nil == self.maxHeight {
					self.maxHeight = $0     // << needed once !!
				}
			}
			.modifier(AnimatingFrameHeight(height: expanded ? maxHeight ?? .infinity : 0))
			.clipped()
			.background(Color.red)
			Text("Thist is another text underneath the huge one. ")
				.font(.system(.headline))
				.foregroundColor(.red)
			Spacer()
		}
		.onAppear {
            // this cases instance redraw on first render
            // so initial state will be invisible for user
			expanded = false    // << set if needed here !!
		}
	}
}

struct AnimatingFrameHeight: AnimatableModifier {
	var height: CGFloat = 0

	var animatableData: CGFloat {
		get { height }
		set { height = newValue }
	}

	func body(content: Content) -> some View {
		content.frame(height: height)
	}
}

struct ViewHeightKey: PreferenceKey {
	static var defaultValue: CGFloat { 0 }
	static func reduce(value: inout Value, nextValue: () -> Value) {
		value = value + nextValue()
	}
}
```
