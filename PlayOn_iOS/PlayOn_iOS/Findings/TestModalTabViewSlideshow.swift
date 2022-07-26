// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestModalTabViewSlideshow: View {
	var body: some View {
		ContentView()
	}
	struct Value: Hashable, Identifiable {
		var id: Int { index }
		var index: Int
		init(_ i: Int) { index = i }
	}

	struct ContentView: View {
		let assets: [String] = (1...32).map { "preview_\($0)"}

		@State private var selection: Value?

		var body: some View {
			VStack {
				Button("Random element") {
					selection = Value(Int.random(in: 1...32))
				}
			}
			.sheet(item: $selection) { _ in
				SlideshowView(selection: $selection, assets: assets)
			}
		}
	}

	struct SlideshowView: View {
		@Binding var selection: Value?
		var assets: [String]
		var body: some View {
			TabView(selection: $selection) {
				ForEach(1..<33, id: \.self) { index in
//                Image(assets[index])
					Image(systemName: "\(index).square")
						.resizable()
						.aspectRatio(contentMode: .fit).tag(Optional(Value(index)))
				}
			}
			.tabViewStyle(PageTabViewStyle())
			.indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
		}
	}

}

struct TestModalTabViewSlideshow_Previews: PreviewProvider {
	static var previews: some View {
		TestModalTabViewSlideshow()
	}
}

extension Int: Identifiable {
	public var id: Int { self }
}
