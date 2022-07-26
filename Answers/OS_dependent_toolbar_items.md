```
🔥BOYCOTT on russia - terrorist must be punished!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: Blank white screen with default Xcode 12 Core Data project (by codewithfeeling)

A: It needs to add some more code - wrap into `NavigationView` and separate placements for buttons (which you can modify to your needs, of course)

Demo prepared with Xcode 12.1 / iOS 14.1

	var body: some View {
		NavigationView {
			List {
				ForEach(items) { item in
					Text("Item at \(item.timestamp!, formatter: itemFormatter)")
				}
				.onDelete(perform: deleteItems)
			}
			.toolbar {
				#if os(iOS)
				ToolbarItem {
					EditButton()
				}
				#endif
				ToolbarItem(placement: .bottomBar) {
					Button(action: addItem) {
						Label("Add Item", systemImage: "plus")
					}
				}
			}
		}
	}
