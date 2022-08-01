>
> 🔥BOYCOTT on russia - terrorist must be punished!<br>
> «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
> 
> ATTENTION: This is a demo - use it as you wish. Reference is appriciated.<br>
> If you want to thank - buy me coffee: [Coffee for Asperi](https://secure.wayforpay.com/donate/asperi)
>

Q: Animate SwiftUI View when .sheet is shown (by cluelessCoder)

A: Transition works when view is appeared in view hierarchy (not on screen), so to solve this we need another container and state.

Here is a fixed variant. Tested with Xcode 12.1 / iOS 14.1

![IwaIK](https://user-images.githubusercontent.com/62171579/182127776-337ab442-dfae-4d91-936b-c84e7a4867d6.gif)

```
struct SheetContentView: View {
	@Binding var showSheet: Bool
	@State private var isShown = false
	var body: some View {
		VStack {            // container to animate transition !!
			if isShown {
				VStack(spacing: 8) {
					Text("A great content of my new sheet")
					Label("still not done", systemImage: "guitars")
					Text("I'm done now")
				}
				.transition(.asymmetric(insertion: .scale, removal: .opacity))
			}
		}
		.animation(Animation.easeInOut(duration: 2))
		.onAppear {
			isShown = true       // << activate !!
		}
	}
}
```
