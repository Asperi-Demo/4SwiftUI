// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestListNoPaddings: View {
	var body: some View {
		Demo()
	}

	struct Demo: View {
		var colors: [Color] = [.red, .blue, .yellow]
		var body: some View {
			List {
				ForEach(colors, id: \.self) { color in
					color
				}.listRowInsets(EdgeInsets())
			}
			.listStyle(PlainListStyle())
		}
	}
}

struct TestListNoPaddings_Previews: PreviewProvider {
	static var previews: some View {
		TestListNoPaddings()
	}
}
