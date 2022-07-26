// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestMenuSortOrderChange: View {
	var body: some View {
		ContentView()
	}

	struct ContentView: View {
		@State private var selectedSort: SortOption = .name
		@State private var isSortAscending = true

		enum SortOption: String, CaseIterable, Identifiable {
			var id: Self { self }
			case name = "Name"
			case number = "Number"
			case length = "Length"
		}

		var sorting: Binding<SortOption> { .init(
			get: { self.selectedSort },
			set: {
				if self.selectedSort == $0 {
					self.isSortAscending.toggle()
				}
				self.selectedSort = $0
			}
		)}

		var body: some View {
			Menu("Sort") {
				Picker(selection: sorting, label: Text("Sorting options")) {
					ForEach(SortOption.allCases) { option in
						HStack {
							Text(option.rawValue)
							Spacer()
							if selectedSort == option {
								Image(systemName: isSortAscending ? "chevron.down" : "chevron.up")
							}
						}
						.tag(option)
					}
				}
			}
		}
	}
}

struct TestMenuSortOrderChange_Previews: PreviewProvider {
	static var previews: some View {
		TestMenuSortOrderChange()
	}
}
