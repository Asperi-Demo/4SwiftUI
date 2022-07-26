// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestInternalTypeModifiers: View {
	var body: some View {
		ContentView()
	}

	struct CustomTextField: View {
		@Binding var text: String

		private var placeholder = "" // << default
		private var border = CGFloat.zero

		init(text: Binding<String>) {
			_text = text
		}

		var body: some View {
			TextField(placeholder, text: $text)
				.border(.gray, width: border)
		}

		func setCustomPlaceholder(placeholder: String = "Enter Text") -> Self {  // << here Self !!
			var tmp = self
			tmp.placeholder = placeholder
			return tmp
		}

		func setBorder(width: CGFloat = 1) -> Self { // << here Self !!
			var tmp = self
			tmp.border = width
			return tmp
		}
	}

	struct ContentView: View {
		@State private var text = "Boycott russia. Help to Stop War!"
		var body: some View {
			CustomTextField(text: $text)
				.setCustomPlaceholder()
				.setBorder()
		}
	}
}

struct TestInternalTypeModifiers_Previews: PreviewProvider {
	static var previews: some View {
		TestInternalTypeModifiers()
	}
}
