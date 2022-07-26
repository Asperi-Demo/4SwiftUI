// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

// On "How to align with a certain view in a VStack? (by Searene)"
struct TestAlignWithCertainVStack: View {
	var body: some View {
		ContentView()
	}

	struct ContentView: View {

		var body: some View {
			HStack(alignment: .firstTextBaseline) {    // << [fix] !!
				VStack(spacing: 5) {
					Text("Foo")
						.padding(.bottom, 0)
					getVerticalLine()
				}
				Text("Bar")
					.padding(10)
					.frame(maxWidth: .infinity, alignment: .leading)
					.background(.yellow)
			}

		}

		private func getVerticalLine() -> some View {
			return Color.gray
				.frame(width: 1, height: 30)
				.padding(.leading, 0)
		}

	}
}

struct TestAlignWithCertainVStack_Previews: PreviewProvider {
	static var previews: some View {
		TestAlignWithCertainVStack()
	}
}
