```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: SwiftUI - show Alert from Button inside of ToolbarItem (by marchinram)

A: The solution is to use alert outside of toolbar and with different constructor. Tested with Xcode 12.1 / iOS 14.1.

![f1nWt](https://user-images.githubusercontent.com/62171579/171996497-e4b79c87-1d75-4c79-b839-a040b3d82234.gif)

```
struct SOQuestionView: View {
	@State private var alertItem: String? // assuming item confirmed to Identifiable
	
	var body: some View {
		NavigationView {
			VStack {
				Text("Click button in toolbar")
			}
			.navigationBarTitle(Text("Title"))
			.toolbar {
				ToolbarItem(placement: .navigationBarLeading) {
					Button(action: {
						alertItem = "Alert 1"
					}) {
						Image(systemName: "square.and.arrow.up")
					}
				}
				ToolbarItem(placement: .navigationBarTrailing) {
					Button(action: {
						alertItem = "Alert 2"
					}) {
						Image(systemName: "square.and.arrow.up.fill")
					}
				}
			}
			.alert(item: $alertItem) { item in
				Alert(title: Text(item))
			}
		}
	}
}
```
