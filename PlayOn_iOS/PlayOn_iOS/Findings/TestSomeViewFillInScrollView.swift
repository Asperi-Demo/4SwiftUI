// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestSomeViewFillInScrollView: View {
	var body: some View {
		ContentView()
	}

	struct ContentView: View {
		@State private var height = CGFloat.zero

		var body: some View {
			NavigationView {
				VStack {
					// Logo and postcode search
					VStack {
						Text("Logo")
							.background(Color.red)

						Text("Title")
							.background(Color.blue)
					}

					.fixedSize(horizontal: false, vertical: true)
					.padding()

					GeometryReader { gp in
						ScrollView(.vertical, showsIndicators: false) {
							VStack(alignment: .leading) {

								Text("Selector")
									.background(Color.yellow)

								Text("Browse")
									.frame(minHeight: height, alignment: .top)
									.background(GeometryReader {
										Color.clear.preference(key: ViewOffsetKey.self,
															   value: $0.frame(in: .named("parent")).origin.y)
									})
									.background(Color.green)
							}
							.navigationBarHidden(true)
						}
						.coordinateSpace(name: "parent")
						.onPreferenceChange(ViewOffsetKey.self) {
							height = gp.size.height - $0
						}
						.frame(maxWidth: .infinity)
					}
				}
				.background(Color.red)
			}
		}
	}
}

struct TestSomeViewFillInScrollView_Previews: PreviewProvider {
	static var previews: some View {
		TestSomeViewFillInScrollView()
	}
}
