// 🔥BOYCOTT on russia - terrorist must be punished!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestExtraSpaceInList: View {
	@State private var value: String = ""

	init() {
		if #available(iOS 16, *) {
			UICollectionView.appearance().contentInset.top = -34
		} else {
			UITableView.appearance().contentInset.top = -34
		}
	}
	var body: some View {
		NavigationView {
			List {
				ForEach(0...10) {
					Text("Item \($0)")

				}
			}
			.searchable(text: $value, placement: .navigationBarDrawer(displayMode: .always))
			.navigationTitle("Title")
			.navigationBarTitleDisplayMode(.inline)
			.border(.red)
		}
	}
}

struct TestExtraSpaceInList_Previews: PreviewProvider {
    static var previews: some View {
        TestExtraSpaceInList()
    }
}
