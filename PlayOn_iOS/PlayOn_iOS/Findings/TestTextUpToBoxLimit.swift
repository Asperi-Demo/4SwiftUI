// 🔥BOYCOTT on russia - terrorist must be punished!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestTextUpToBoxLimit: View {
	var body: some View {
		VStack(spacing: 20) {
			HStack(spacing: 0) {
				Text("»")
				TextBox("Some Text")
					.background(Color.yellow)
					.border(.black, width: 1)
				Text("«")
			}
			
			HStack(spacing: 0) {
				Text("»")
				TextBox("A longer text that should wrap to the next line.")
					.background(Color.yellow)
					.border(.black, width: 1)
				Text("«")
			}
		}
	}
	
	struct TextBox: View {
		private let string: LocalizedStringKey
		private let maxWidth: CGFloat
		
		@State private var width: CGFloat
		
		init(_ text: LocalizedStringKey, maxWidth: CGFloat = 200) {  // << any default value
			self.string = text
			self.maxWidth = maxWidth
			self._width = State(initialValue: maxWidth)
		}
		
		var body: some View {
			Text(string)
				.background(GeometryReader {
					Color.clear
						.preference(key: ViewSideLengthKey.self, value: $0.frame(in: .local).size.width)
				})
				.onPreferenceChange(ViewSideLengthKey.self) {
					self.width = min($0, maxWidth)
				}
				.frame(maxWidth: width)
		}
	}
}

struct TestTextUpToBoxLimit_Previews: PreviewProvider {
	static var previews: some View {
		TestTextUpToBoxLimit()
	}
}
