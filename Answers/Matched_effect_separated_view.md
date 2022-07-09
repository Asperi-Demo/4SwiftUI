```
🔥BOYCOTT on russia - terrorist must be punished!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: How to properly use matchedGeometry? (by Markon)

A: The following variant works in Preview as well. The `frame` should be AFTER `matchedGeometryEffect` and animation
should be applied to container.

Tested with Xcode 12.0 / iOS 14

![xNLNZ](https://user-images.githubusercontent.com/62171579/178094756-71108c48-fa3b-46ec-8eba-824c6885edc4.gif)

```
struct ContentView: View {
	@State var details = false
	@Namespace var animation
	
	var body: some View {
		ZStack {
			HStack {
				if !details {
					Rectangle()
						.matchedGeometryEffect(id: "id1", in: animation)
						.frame(width: 100, height: 100)
						.onTapGesture {
							details.toggle()
						}
				}
				Spacer()
			}.animation(.default, value: details)
			
			if details {
				AnotherView(details: $details, animation: animation)
			}
		}.animation(.default, value: details)
	}
}


struct AnotherView: View {
	@Binding var details: Bool
	var animation: Namespace.ID
	
	var body: some View {
		ZStack {
			Color.red
			
			Rectangle()
				.matchedGeometryEffect(id: "id1", in: animation)
				.frame(width: 300, height: 300)
				.onTapGesture {
					details.toggle()
				}
		}
	}
}
```
