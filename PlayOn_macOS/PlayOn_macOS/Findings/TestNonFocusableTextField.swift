// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestNonFocusableTextField: View {

	@State private var text = "Hello"
	var body: some View {
		VStack {
			MyTextField(text: $text)
			TextField("", text: $text)
		}
		.padding()
	}

	struct MyTextField: NSViewRepresentable {
		@Binding var text: String

		func makeNSView(context: Context) -> NSTextField {
			let field = TextFieldImp()
			return field
		}

		func updateNSView(_ nsView: NSTextField, context: Context) {
			nsView.stringValue = text
		}

		private class TextFieldImp: NSTextField {
			// 1) block auto-focus
			override var acceptsFirstResponder: Bool { false }

			// 2) drop focus on commit
			override func textDidEndEditing(_ notification: Notification) {
				super.textDidEndEditing(notification)
				self.window?.makeFirstResponder(nil)
			}
		}
	}
}

struct TestNonFocusableTextField_Previews: PreviewProvider {
	static var previews: some View {
		TestNonFocusableTextField()
	}
}
