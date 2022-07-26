// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestImageRectCornersGet: View {
	var body: some View {
		ZStack {
			Image("picture")
				.resizable()
				.scaledToFit()

				.background(GeometryReader {
					Color.clear.preference(key: ViewRectKey.self,
												  value: [$0.frame(in: .global)])
				})
				.onPreferenceChange(ViewRectKey.self) { rects in
					print(rects.first ?? .zero)
					// calculate here !!
				}
		}.edgesIgnoringSafeArea(.all)
	}
}

struct TestImageRectCornersGet_Previews: PreviewProvider {
	static var previews: some View {
		TestImageRectCornersGet()
	}
}
