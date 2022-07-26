```
🔥BOYCOTT on russia - terrorist must be punished!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: How can I create a smooth colour change animation using swiftUI? (Example in question) (by Hubert Rzeminski)

A: Here is a demo of possible approach - just use some shape (circle in this case) between text and opaque background and move it depending on state.

Prepared with Xcode 12.4 / iOS 14.4

*Note: we can use just tap gesture instead of button and tune all parameters and colors, but in general the idea remains the same*

![mRPU6](https://user-images.githubusercontent.com/62171579/180370444-3557f615-ff7b-49f5-b9fd-de55eb2e51cb.gif)

```
struct DemoView: View {
	@State private var playing = false
	var body: some View {
		Button(action: { playing.toggle() }) {
			HStack{
				Image(systemName: playing ? "pause" : "play")
				Text(playing ? "STOP" : "PLAY")
					.bold()
			}
			.background(
				Circle().fill(Color.purple)
					.frame(width: 160, height: 160, alignment: .leading)
					.blur(radius: 3)
					.offset(x: playing ? 0 : -160, y: -40)
					.animation(.easeInOut(duration: 1), value: playing)
			)
			.padding()
			.foregroundColor(.white)
			.background(Color.green)
			.cornerRadius(25)
			.clipped()
			.shadow(radius: 20)
		}
	}
}
```
