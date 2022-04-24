// BOYCOTT on ᵣussia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard
//
// ATTENTION: 	By using this you agree do not repost any part of this code
//					on StackOverflow site. Thanks, Asperi.

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
