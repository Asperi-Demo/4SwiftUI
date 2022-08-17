>
> 🔥BOYCOTT on russia - terrorist must be punished!<br>
> «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
> 
> ATTENTION: This is a demo - use it as you wish. Reference is appriciated.<br>
> If you want to thank - buy me coffee: [Coffee for Asperi](https://secure.wayforpay.com/donate/asperi)
>

Q: Presenting Sheet modally in SwiftUI (by RXP)

A: The solution is to use `sheet(item:` variant with content depending on menu selection mode
 which changed by menu item.

Here is working code (there are many changes so all components included). Tested with Xcode 12.1 / iOS 14.1

![S3x9b](https://user-images.githubusercontent.com/62171579/185108383-e5351aaf-c3c0-4654-a1ab-3da1c1dfb971.gif)

```
enum SheetView: Identifiable {
	var id: Self { self }
	case add, edit
}

struct ContentView: View {
	@State private var showSheet: SheetView? = nil
	
	var body: some View {
		GeometryReader { g in
			NavigationView {
				Text("Main Page")
					.padding()
					.navigationBarTitle("Main Page")
					.navigationBarItems(trailing: actionItems)
			}
		}.sheet(item: $showSheet) { mode in
			content(for: mode)
		}
	}
	
	var actionItems: some View {
		Menu {
			Button(action: {
				showSheet = .add
			}) {
				Label("Add Asset", systemImage: "plus")
			}
			Button(action: {
				showSheet = .edit
			}) {
				Label("Edit Asset", systemImage: "minus")
			}
		} label: {
			Image(systemName: "dot.circle.and.cursorarrow").resizable()
		}
	}
	
	@ViewBuilder
	func content(for mode: SheetView) -> some View {
		switch mode {
		case .add:
			AddAsset(showSheet: $showSheet)
		case .edit:
			EditAsset(showSheet: $showSheet)
		}
	}
	
}

struct AddAsset: View {
	@Binding var showSheet: SheetView?
	
	var body: some View {
		NavigationView {
			Text("Add Asset")
				.navigationBarTitle(Text("Add"), displayMode: .inline)
				.navigationBarItems(trailing: Button(action: {
					print("Dismissing sheet view...")
					self.showSheet = nil
				}) {
					Text("Done").bold()
				})
		}
	}
}

struct EditAsset: View {
	@Binding var showSheet: SheetView?
	var body: some View {
		NavigationView {
			Text("Edit Asset")
				.navigationBarTitle(Text("Edit"), displayMode: .inline)
				.navigationBarItems(trailing: Button(action: {
					print("Dismissing sheet view...")
					self.showSheet = nil
				}) {
					Text("Done").bold()
				})
		}
	}
}
```
