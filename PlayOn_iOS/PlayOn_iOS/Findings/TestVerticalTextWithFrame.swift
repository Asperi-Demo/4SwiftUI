// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestVerticalTextWithFrame: View {
	var body: some View {
		ContentView()
	}

	struct ContentView: View {
		@State private var size = CGSize.zero
		var body: some View {
			HStack(spacing: 10) {
				Text("Distance")
					.fixedSize()
					.background(GeometryReader {
						Color.clear
							.preference(key: ViewSizeKey.self, value: $0.frame(in: .local).size)
					})
					.onPreferenceChange(ViewSizeKey.self) {
						self.size = $0
					}
					.rotationEffect(.degrees(270))
					.frame(width: size.height, height: size.width)
					.foregroundColor(.black)
					.minimumScaleFactor(0.01)

				Rectangle()
					.foregroundColor(.black)
					.frame(width: 3)
					.padding([.top, .bottom])
				Spacer()
			}
		}
	}

}

struct TestVerticalTextWithFrame_Previews: PreviewProvider {
	static var previews: some View {
		TestVerticalTextWithFrame()
	}
}
