```
🔥BOYCOTT on russia - terrorist must be punished!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: Scale Text in overlay without blurring (by user2926577)

A: The `scaleEffect` scale view like an image, instead you have to scale background and text separately, scaling font for `Text` so it is rendered properly.

Here is a demo of possible approach. Tested with Xcode 13.1 / iOS 15.1

![Screenshot 2022-07-02 at 17 21 04](https://user-images.githubusercontent.com/62171579/177004729-990c2d8e-424d-49ee-ae3a-c80005c890d4.png)

left: scale = 1 right: scale = 8


```
struct ZoomFontView: View {

	let scale: CGFloat = 8
    var body: some View {
    	ZStack {
        Rectangle()
            .frame(maxWidth: 100, maxHeight: 100)
            .foregroundColor(Color.mint)
            .scaleEffect(1 * scale) // Placeholder for MagnificationGesture
			Text("Hello").font(.system(size: 18 * scale))
				.fixedSize()
		}
    }
}
```
