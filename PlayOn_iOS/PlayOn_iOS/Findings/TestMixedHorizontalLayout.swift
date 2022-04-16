// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard
//
// ATTENTION: 	By using this you agree do not repost any part of this code
//					on StackOverflow site. Thanks, Asperi.

import SwiftUI

struct TestMixedHorizontalLayout: View {
	let fixed1: CGFloat = 100
	let fixed2: CGFloat = 140

	var body: some View {
		HStack(spacing: 0) {
			Color.red
				.frame(width: fixed1)

			GeometryReader { gp in
				HStack (spacing: 0) {
					Color.green
							.frame(width: (gp.size.width - fixed2) * 2/3)
					Color.blue
						.frame(width: fixed2)
					Color.purple
				}
			}

		}
		.background(Color.gray)
		.frame(maxWidth: .infinity, maxHeight: 50)
	}
}

struct TestMixedHorizontalLayout_Previews: PreviewProvider {
	static var previews: some View {
		TestMixedHorizontalLayout()
	}
}
