// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard
//
// ATTENTION: 	By using this you agree do not repost any part of this code
//					on StackOverflow site. Thanks, Asperi.

import SwiftUI

struct TestMasonry: View {
	let wSpacing = CGFloat(4)
	let hSpacing = CGFloat(4)
	let columns = 3

	struct Item: Identifiable {
		let id = UUID()
		let height: CGFloat
	}

	let items: [Item] = (0...99).map { _ in Item(height: CGFloat([43, 87, 121, 204].randomElement()!)) }

	var body: some View {
		GeometryReader { gp in
			ScrollView {
				HStack(alignment: .top, spacing: wSpacing) { // Lazy not needed and gives incorrect layout
					let sub = items.count / columns
					ForEach(1..<columns+1, id: \.self) { i in
						LazyVStack(spacing: hSpacing) {
							ForEach(calculatedItems(i, sub)) { item in
								Rectangle().stroke(.red, lineWidth: 2)
									.frame(height: item.height)
									.background(.green.opacity(0.3))
									.onAppear {
										// confirms appear on-scroll !!
										print(">> \(i):\(item.id)")
									}

							}
						}
						.frame(width: (gp.size.width - wSpacing * CGFloat(columns - 1))/3)
					}
				}
			}
		}
	}

	func calculatedItems(_ i: Int, _ sub: Int) -> ArraySlice<Item> {
		items[(i-1)*sub..<(i*sub > items.count ? items.count : i*sub)]
	}
}


struct TestMasonry_Previews: PreviewProvider {
    static var previews: some View {
        TestMasonry()
    }
}
