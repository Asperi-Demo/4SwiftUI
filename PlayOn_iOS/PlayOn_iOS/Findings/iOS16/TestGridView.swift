// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

#if canImport(Charts)        // to block Xcode 13+ compiler error on Grid
@available(iOS 16.0, *)
struct TestGridView: View {

	var body: some View {
		ProtoGrid()
	}

	struct ProtoGrid: View {
		@State var index1 = 15.0
		@State var index2 = 5.0
		@State var index3 = 225.0

		@State private var imageWidth = CGFloat.zero

		var body: some View {
			VStack {
				Rectangle()
					.fill(Color.red)

				Grid {
					GridRow {
						Image(systemName: "person").imageScale(.large)
						Slider(value: $index1, in: 0...10)
						Text("\(String(format: "%.2f", index1))").font(Font.system(.body).monospacedDigit())
					}
					GridRow {
						Image(systemName: "megaphone").imageScale(.large)
						Slider(value: $index2, in: 0...10)
						Text("\(String(format: "%.2f", index2))").font(Font.system(.body).monospacedDigit())
					}
					GridRow {
						Image(systemName: "ruler").imageScale(.large)
						Slider(value: $index3, in: 0...10)
						Text("\(String(format: "%.2f", index3))").font(Font.system(.body).monospacedDigit())
							.gridColumnAlignment(.trailing)
					}
				}
			}
			.padding()
		}
	}
}

@available(iOS 16.0, *)
struct TestGridView_Previews: PreviewProvider {
	static var previews: some View {
		TestGridView()
	}
}
#endif
