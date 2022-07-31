// 🔥BOYCOTT on russia - terrorist must be punished!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestSearchableScrollViewAnimation: View {
    @State var searchText: String = ""

    @State private var isSearching = false   // track searching
    @State private var toggledSearch = false // activate transform

    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                CustomListView()
            }
            .transaction {
            	if isSearching || toggledSearch {
					// increased speed to avoid views overlaping
					$0.animation = .default.speed(1.2)

					// needed to animate end of searching
					toggledSearch.toggle()
				}
			}
            .navigationTitle("Misbehaving ScrollView")
            .background(
            	// read current searching state is available only in
            	// child view level environment
            	SearchingReaderView(searching: $isSearching)
            )
			.searchable(text: $searchText, placement: .automatic)
            .animation(.easeInOut, value: isSearching)
        }
    }

	struct SearchingReaderView: View {
		@Binding var searching: Bool
		@Environment(\.isSearching) private var isSearching

		var body: some View {
			Text(" ")
				.onChange(of: isSearching) {
					searching = $0    // << report to parent
				}
		}
	}
}

struct CustomListView: View {
    @State private var listItems = ["Item 0", "Item 1", "Item 2", "Item 3", "Item 4", "Item 5", "Item 6", "Item 7", "Item 8", "Item 9", "Item 10"]

    var body: some View {
        LazyVStack(alignment: .leading, spacing: 10) {
            ForEach(listItems, id: \.self) { item in
                CustomListItemView(item: item)
                    .padding(.horizontal)
            }
        }
    }
}

struct CustomListItemView: View {
    @State var item: String

    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .foregroundColor(.green.opacity(0.1))
            VStack(alignment: .leading, spacing: 4) {
                Text(item)
                    .font(.headline)
                Text(item)
                    .font(.subheadline)
            }
            .padding(25)
        }
    }
}
struct TestSearchableScrollViewAnimation_Previews: PreviewProvider {
    static var previews: some View {
        TestSearchableScrollViewAnimation()
    }
}
