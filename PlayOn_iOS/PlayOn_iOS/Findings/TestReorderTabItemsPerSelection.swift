// 🔥BOYCOTT on russia - terrorist must be punished!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestReorderTabItemsPerSelection: View {

	@State private var selection: String = "home"

	struct Item {
		let title: String
		let color: Color
		let icon: String
	}
	@State var items = [
		Item(title: "cart", color: .red, icon: "cart"),
		Item(title: "home", color: .blue, icon: "house"),
		Item(title: "car", color: .green, icon: "car"),
	]
	var body: some View {

		TabView(selection: $selection) {
			ForEach(items, id: \.title) { item in
				item.color
					.tabItem {
						Image(systemName: item.icon)
						Text(item.title)
					}
			}
		}
		.onChange(of: selection) { title in
			let target = 1
			if var i = items.firstIndex(where: { $0.title == title }) {
				if i > target {
					i += 1
				}
				items.move(fromOffsets: IndexSet(integer: target), toOffset: i)
			}
		}
	}
}

struct TestReorderTabItemsPerSelection_Previews: PreviewProvider {
    static var previews: some View {
        TestReorderTabItemsPerSelection()
    }
}
