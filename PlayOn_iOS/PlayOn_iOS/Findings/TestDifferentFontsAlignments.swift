// 🔥BOYCOTT on russia - terrorist must be punished!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestDifferentFontsAlignments: View {

	let bigFont = UIFont.systemFont(ofSize: 60)
	let smallFont = UIFont.preferredFont(forTextStyle: .body)

	var body: some View {
			HStack(alignment: .lastTextBaseline) {
				Text("AAA")
					.font(Font(bigFont as CTFont))
				ZStack(alignment: .leading) {
					VStack {
						Text("BBBB")
							// to be exactly at top in own glyph rect
							.offset(y: -CTFontGetDescent(smallFont as CTFont))
					}
					.frame(maxHeight: .infinity, alignment: .top)
					Text("CC")
				}
				.font(Font(smallFont as CTFont))
				.frame(maxHeight: .infinity, alignment: Alignment(horizontal: .leading, vertical: .lastTextBaseline))
			}
			.fixedSize()
	}
}

struct TestDifferentFontsAlignments_Previews: PreviewProvider {
    static var previews: some View {
        TestDifferentFontsAlignments()
    }
}
