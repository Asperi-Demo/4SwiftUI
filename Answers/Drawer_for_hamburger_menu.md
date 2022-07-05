```
🔥BOYCOTT on russia - terrorist must be punished!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: Hamburger Navigation Menu Slide Animation in Swiftui (by Malav Soni)

A: It is better to keep control over appearance/disappearance inside menu view. Find below fixed parts, places are highlighted with comments in code.

Tested with Xcode 12.5 / iOS 14.5

*Note: demo prepared with turned on "Simulator > Debug > Slow Animations" for better visibility*

![J7kcP](https://user-images.githubusercontent.com/62171579/176986516-8d006fd0-3a1c-40b6-ac84-37245b1c326e.gif)

```
struct LeftNavigationView:View {
	@EnvironmentObject var viewModel:ViewModel
	var body: some View {
		ZStack {
			if self.viewModel.isLeftMenuVisible {     // << here !!
				Color.black.opacity(0.8)
					.ignoresSafeArea()
					.transition(.opacity)

				VStack {
					Button(action: {
						self.viewModel.isLeftMenuVisible.toggle()
					}, label: {
						Text("Close Me")
					})
				}
				.frame(maxWidth:.infinity, maxHeight: .infinity)
				.background(Color.white)
				.cornerRadius(10)
				.padding(.trailing)
				.padding(.trailing)
				.padding(.trailing)
				.padding(.trailing)
				.transition(
					.asymmetric(
						insertion: .move(edge: .leading),
						removal: .move(edge: .leading)
					)
				).zIndex(1)  // << force keep at top where removed!!
			}
		}
		.frame(maxWidth: .infinity, maxHeight: .infinity)
		.animation(.default, value: self.viewModel.isLeftMenuVisible)  // << here !!
	}
}

struct ContentView: View {
	@StateObject var viewModel = ViewModel()
	var body: some View {
		ZStack {
			NavigationView {
				VStack(alignment:.leading) {
					Button(action: {
						self.viewModel.isLeftMenuVisible.toggle()
					}, label: {
						Text("Button")
					})
				}.padding(.horizontal)
				.navigationTitle("ContentView")
			}

            // included here, everything else is managed inside (!) view
			LeftNavigationView()

		}.environmentObject(self.viewModel)
	}
}

```
