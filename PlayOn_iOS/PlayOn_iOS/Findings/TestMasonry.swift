// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestMasonry: View {
	let wSpacing = CGFloat(4)
	let hSpacing = CGFloat(4)
	let columns = 3

	struct Item: Identifiable {
		let id = UUID()
		let height: CGFloat = CGFloat([43, 87, 121, 204].randomElement()!)
	}

	@State private var items: [Item] = (0...99).map { _ in Item() }

	var body: some View {
//		GeometryReader { gp in // actually not needed for now (was needed for LazyHStack, which appeared not needed)
			ScrollView {
				HStack(alignment: .top, spacing: wSpacing) { // Lazy not needed and gives incorrect layout
					let sub = items.count / columns
					ForEach(1..<columns+1, id: \.self) { i in
						LazyVStack(spacing: hSpacing) {
							ForEach(Array(calculatedItems(i, sub).enumerated()), id: \.1.id) { num, item in
								Cell(num, item: item)
									.onAppear {
										// confirms appear on-scroll !!
										print(">> \(i)-\(num):\(item.id)")

										// add next if close to the end (infinite scroll)
										if num > items.count/3 - columns {
											items.append(contentsOf: (0...9).map { _ in Item() })
										}
									}
									.onDisappear{
										// confirms disappear on-scroll !!
										print("<<<<<< \(i):\(item.id)")
									}
							}
						}
//						.frame(width: (gp.size.width - wSpacing * CGFloat(columns - 1)) / CGFloat(columns))
					}
				}
			}
//		}
	}

	struct Cell: View {
		let index: Int
		let item: Item

		init(_ index: Int, item: Item) {
			self.index = index
			self.item = item
			print("== \(index)")
		}

		var body: some View {
			Rectangle().stroke(.red, lineWidth: 2)
				.frame(height: item.height)
				.background(.green.opacity(0.3))
				.onAppear {
					// confirms appear on-scroll - works here as well !!
				}
				.onDisappear{
					// confirms disappear on-scroll - works here as well !!
				}
		}
	}

	func calculatedItems(_ i: Int, _ sub: Int) -> ArraySlice<Item> {
		// 1st try: just split by 3
		items[(i-1)*sub..<(i*sub > items.count ? items.count : i*sub)]
		// 2d try: TODO: fill by columns
		// 3d try: TODO: dynamic balancing by filled column height
	}
}


struct TestMasonry_Previews: PreviewProvider {
    static var previews: some View {
        TestMasonry()
    }
}
