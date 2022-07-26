// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestMixedGridLayout: View {
	var body: some View {
		ContentView()
	}

	struct ContentView: View {
		let arr = (1...19).map { "\($0)" }

		struct Row: View {
			let i: Int
			let items: [String]

			var body: some View {
				HStack(spacing: 5) {
					NavigationLink {
						Text("Details " + items[i])
					} label: {
						Color.gray
							.cornerRadius(6).overlay(Text(items[i]))
					}
					if i + 1 < items.count {
						NavigationLink {
							Text("Details" + items[i+1])
						} label: {
							Color.gray
								.cornerRadius(6).overlay(Text(items[i+1]))
						}
					}
					else {
						Color.clear
					}
				}
				.frame(height: 250)
			}
		}

		struct AdView: View {
			var body: some View {
				VStack(spacing: 0) {
					Color.blue
					Color.yellow
				}
				.frame(width: UIScreen.main.bounds.width, height: 140)
				.overlay(Text("STOP WAR").font(.largeTitle).bold())
			}
		}

		var body: some View {
			ScrollView(.vertical, showsIndicators: false) {
				LazyVStack(spacing: 5) {
					ForEach(Array(stride(from: arr.startIndex, through: arr.endIndex, by: 2)), id: \.self) { i in
						if i != 0 && i % 4 == 0 {
							AdView()
						}
						Row(i: i, items: arr)
							.padding(.horizontal)
					}
				}
			}
		}
	}
}

struct TestMixedGridLayout_Previews: PreviewProvider {
	static var previews: some View {
		TestMixedGridLayout()
	}
}
