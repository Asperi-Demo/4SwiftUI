>
> 🔥BOYCOTT on russia - terrorist must be punished!<br>
> «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
> 
> ATTENTION: This is a demo - use it as you wish. Reference is appriciated.<br>
> If you want to thank - buy me coffee: [Coffee for Asperi](https://secure.wayforpay.com/donate/asperi)
>

Q: How to drag across Views in a LazyVGrid with GeometryReader? (by user3338488)

A: Here is a possible approach based on drag gesture in parent.

Tested with Xcode 12.1 / iOS 14.1

![1IOsE](https://user-images.githubusercontent.com/62171579/186473569-0f5e6772-1460-4f9b-8e3f-464d44dd9164.gif)

```
struct ContentView: View {
	let data = (0...3)
	
	@State private var colors: [Color]
	@State private var rect: [CGRect]
	
	init() {
		_colors = State(initialValue: Array(repeating: .gray, count: data.count))
		_rect = State(initialValue: Array(repeating: .zero, count: data.count))
	}
	
	var columns: [GridItem] =
		Array(repeating: .init(.fixed(70), spacing: 1), count: 2)
	
	var body: some View {
		LazyVGrid(columns: columns, spacing: 1) {
			ForEach(data, id: \.self) { item in
				Rectangle()
					.fill(colors[item])
					.frame(width: 70, height: 70)
					.overlay(
						GeometryReader{ geo in
							Color.clear
								.onAppear {
									rect[item] = geo.frame(in: .global)
								}
						}
					)
			}
		}
		.gesture(DragGesture(minimumDistance: 0, coordinateSpace: .global)
						.onChanged({ (value) in
							if let match = rect.firstIndex(where: { $0.contains(value.location) }) {
								colors[match] = Color.red
							}
						})
		)
	}
}
```
