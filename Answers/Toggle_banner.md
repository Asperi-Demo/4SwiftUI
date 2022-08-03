>
> 🔥BOYCOTT on russia - terrorist must be punished!<br>
> «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
> 
> ATTENTION: This is a demo - use it as you wish. Reference is appriciated.<br>
> If you want to thank - buy me coffee: [Coffee for Asperi](https://secure.wayforpay.com/donate/asperi)
>

Q: SwiftUI: Animate offset to slide in from off screen (by XmasRights)

A: It can be done just with transition, like

![zvxwe](https://user-images.githubusercontent.com/62171579/182541442-c9eb9b84-81ac-421b-a2ee-4038adb4b4c8.gif)

Tested with Xcode 13.3 / iOS 15.4

```
struct ContentView: View {

	@State var isShowingBanner = true

	var body: some View {
		VStack {
			VStack {
				Spacer()

				if isShowingBanner {
					BannerView()
						.transition(.move(edge: .bottom))  // << here !!
				}
			}
// >> empty container should not shrink !!
			.frame(maxWidth: .infinity, maxHeight: .infinity) 
			.border(Color.black, width: 1.0)
			.clipped()


			Spacer()

			Button("Toggle Banner") {
				withAnimation {
					isShowingBanner.toggle()
				}
			}
		}
		.padding()
	}
}
```
