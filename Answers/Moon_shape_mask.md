>
> 🔥BOYCOTT on russia - terrorist must be punished!<br>
> «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
> 
> ATTENTION: This is a demo - use it as you wish. Reference is appriciated.<br>
> If you want to thank - buy me coffee: [Coffee for Asperi](https://secure.wayforpay.com/donate/asperi)
>

Q: swiftUI moon shape (by test testing)

A: Here is a demo of possible approach. Tested with Xcode 12 / iOS 14.

![lc3Pk](https://user-images.githubusercontent.com/62171579/182878220-c0f8e834-a6f1-48c6-81b3-8187ab6a9c02.png)

```
struct MoonMask: Shape {
	func path(in rect: CGRect) -> Path {
		var path = Rectangle().path(in: rect)
		path.addPath(Circle().path(in: rect.inset(by: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 10))
			.offsetBy(dx: 50, dy: -10)))
		return path
	}
}

struct MoonView: View {
	var body: some View {

		Circle()
			.mask(MoonMask().fill(style: FillStyle(eoFill: true)))

            // below is just demo
			.frame(width: 200, height: 200)
			.foregroundColor(Color.yellow)
			.padding().background(Color.black)
	}
}
```
