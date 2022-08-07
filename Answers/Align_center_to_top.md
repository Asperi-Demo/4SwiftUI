>
> 🔥BOYCOTT on russia - terrorist must be punished!<br>
> «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
> 
> ATTENTION: This is a demo - use it as you wish. Reference is appriciated.<br>
> If you want to thank - buy me coffee: [Coffee for Asperi](https://secure.wayforpay.com/donate/asperi)
>

Q: How can I make a view align it's center to the top of another view in SwiftUI? (by sak)

A: A possible approach is to use `alignmentGuide` modifier, which allows to fit specific internal alignment line to parent container. So by default containers have center alignment, so using top anchor instead for one of views result in align other's center to top.

Tested with Xcode 13.2 / iOS 15.2

![hwuSd](https://user-images.githubusercontent.com/62171579/183284161-c26527fb-7b36-4551-9c10-3185b2d2327d.png)

```
struct DemoView: View {
	var body: some View {
		ZStack {
			Rectangle().fill(.red)
				.frame(width: 300, height: 200)
				.alignmentGuide(VerticalAlignment.center) {   // << here !!
					$0[VerticalAlignment.top]
				}
			Rectangle().fill(.green)
				.frame(width: 100, height: 80)
		}
		.border(Color.black)
	}
}
```
