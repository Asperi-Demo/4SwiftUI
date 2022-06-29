```
🔥BOYCOTT on russia - terrorist must be punished!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: SwiftUI animating the width of RoundedRectangle from 0 to width onAppear? (by GarySabo)

A: Here is a bit modified code that works with Xcode 12.1 / iOS 14.1. So the issue might be either in place of usage or in `getFillWidth` function.

![xeDxb](https://user-images.githubusercontent.com/62171579/176424849-5aa53870-62f7-486b-a367-fe3c850e3d06.gif)

```
struct TestBarView: View {
	@State private var value = 0.0
	var body: some View {
		BarView(progress: value)
			.onAppear {
				value = 0.8
			}
	}
}

struct BarView: View {
	
	var progress: Double = 0.0
	
	var progressAnimation: Animation {
		Animation
			.linear
			.speed(0.5)
			.delay(0.02)
	}
	
	var body: some View {
		
		ZStack {
			ZStack(alignment: .leading) {
				RoundedRectangle(cornerRadius: 12.0)
					.fill(Color(.lightGray))
					.opacity(0.1)
					.frame(height: 15)
					.overlay(GeometryReader { geometry in
						RoundedRectangle(cornerRadius: 12.0)
							.fill(Color.blue)
							.frame(width: geometry.size.width * CGFloat(progress), height: 15)
							.animation(self.progressAnimation)
					}, alignment: .leading)
			}
		}
	}
}
```
