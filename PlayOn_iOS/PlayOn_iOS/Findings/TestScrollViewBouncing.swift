// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestScrollViewBouncing: View {
	var body: some View {
		ContentView()
	}

	struct ContentView: View {
		var body: some View {
			GeometryReader { geo in
				ScrollView {
					Rectangle()
						.frame(width: geo.size.width, height: 1800)
						.foregroundColor(.black)
						.background(ScrollViewConfigurator {
							$0?.bounces = false               // << here !!
						})
					Spacer()
				}
			}
		}
	}

}

struct TestScrollViewBouncing_Previews: PreviewProvider {
	static var previews: some View {
		TestScrollViewBouncing()
	}
}
