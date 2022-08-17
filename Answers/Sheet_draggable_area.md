>
> 🔥BOYCOTT on russia - terrorist must be punished!<br>
> «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
> 
> ATTENTION: This is a demo - use it as you wish. Reference is appriciated.<br>
> If you want to thank - buy me coffee: [Coffee for Asperi](https://secure.wayforpay.com/donate/asperi)
>

Q: How to change DragGesture of sheet for a specific area? (by Erik)

A: The possible solution is to use background of sheet (of needed area) with blocked `DragGesture`. 

![w6TQU](https://user-images.githubusercontent.com/62171579/185088181-8e6d99ca-7966-44a1-bf93-0f3e211fa102.gif)

```
struct TestSheetDraggableArea: View {
	@State private var show = false
	var body: some View {
		Button(action: { show = true }, label: { Text("Open") })
			.sheet(isPresented: $show){
				SheetView()
			}
	}
}

struct SheetView: View {

	var body: some View {
		GeometryReader { gp in
			VStack(spacing: 0) {
				Color.red.overlay(Text("Draggable Area"))
					.frame(height: gp.size.height * 0.1)
				Color.clear.overlay(
					Text("Sheet view")      // << content here
				)
				.contentShape(Rectangle())  // makes hit testable
				.gesture(DragGesture())     // << blocks sheet dragging !!!
			}
		}.ignoresSafeArea()
	}
}
```
