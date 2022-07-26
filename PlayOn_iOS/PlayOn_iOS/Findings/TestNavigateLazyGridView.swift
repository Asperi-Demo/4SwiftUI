// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestNavigateLazyGridView: View {
	struct Item: Identifiable {
		var id: Int { value }
		var value: Int
	}
	@State var selectedItem: Item?

	private let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
	private let items = (0..<100).map { Item(value: $0) }

	var isActive: Binding<Bool> {
		Binding(get: {selectedItem != nil}, set: {_ in selectedItem = nil})
	}

	var body: some View {
		NavigationView {
			ScrollView {
				LazyVGrid(columns: columns) {
					ForEach(items) { item in
						RoundedRectangle(cornerRadius: 16).fill(.yellow)
							.frame(maxWidth: .infinity).aspectRatio(1, contentMode: .fit)
							.overlay(Text("Item \(item.value)"))
							.onTapGesture {
								selectedItem = item
							}
					}
				}
			}
			.padding(.horizontal)
			.background(
				NavigationLink(destination: DetailView(item: selectedItem), isActive: isActive) {
					EmptyView()
				}
			)
			.toolbar {
				Button("Random") { selectedItem = items.randomElement() }
			}
		}
	}

	struct DetailView: View {
		let item: Item?
		var body: some View {
			if let item = item {
				Text("Details for: \(item.value)")
			}
		}
	}
}


struct TestNavigateLazyGridView_Previews: PreviewProvider {
    static var previews: some View {
        TestNavigateLazyGridView()
    }
}
