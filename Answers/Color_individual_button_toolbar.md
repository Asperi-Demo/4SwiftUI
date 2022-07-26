```
🔥BOYCOTT on russia - terrorist must be punished!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: SwiftUI: Setting individual colors for .toolbar ToolbarItem? (by SunriseHurts)

A: It looks like all standard types (button, image, text, etc) are intercepter by ToolbarItem and converted into appropriate internal representation. But custom view (eg. shape based)... is not. So see below a demo of possible approach.

Demo prepared & tested with Xcode 12 / iOS 14.

![o0ZR8](https://user-images.githubusercontent.com/62171579/178284897-55b88f90-84d1-4251-82ea-17eee9b2ebed.gif)

    ToolbarItem(placement: .bottomBar) {
		ShapeButton(shape: Rectangle(), color: .red) {
			print(">> works")
		}
    }

and simple custom Shape-based button

```
struct ShapeButton<S:Shape>: View {
	var shape: S
	var color: Color
	var action: () -> ()

	@GestureState private var tapped = false
	var body: some View {
		shape
			.fill(color).opacity(tapped ? 0.4 : 1)
			.animation(.linear(duration: 0.15), value: tapped)
			.frame(width: 18, height: 18)
			.gesture(DragGesture(minimumDistance: 0)
				.updating($tapped) { value, state, _ in
					state = true
				}
				.onEnded { _ in
					action()
				})
	}
}
```
