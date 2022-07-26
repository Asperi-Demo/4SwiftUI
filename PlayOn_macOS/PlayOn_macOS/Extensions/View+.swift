// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

extension View {
	func gettingInWindow(rect: Binding<CGRect>) -> some View {
		self.modifier(ReadInWindowRectModifier(rect: rect))
	}
}

struct ReadInWindowRectModifier: ViewModifier {
	@Binding var rect: CGRect
	func body(content: Content) -> some View {
		VStack {
			content.background(GeometryReader {
				Color.clear.preference(key: ViewRectKey.self, value: $0.frame(in: .global))
			})
		}
		.onPreferenceChange(ViewRectKey.self) {
			rect = $0
		}
	}
}

