// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard
//
// ATTENTION: 	By using this you agree do not repost any part of this code
//					on StackOverflow site. Thanks, Asperi.

import SwiftUI

struct TestBackgroundOfFocusedTextField: View {
	@State private var text = ""

	var body: some View {
		VStack {
			FindNavigatorSearchBar(
				title: "placeholder",
				text: $text
			)
			TextField("Standard TextField", text: .constant(""))
				.padding(.vertical)
		}
		.padding()
	}

	struct FindNavigatorSearchBar: View {
		let title: String

		@Binding var text: String
		@FocusState private var focused: Bool
		
		var body: some View {
			HStack {
				Image(systemName: "magnifyingglass")
					.foregroundColor(Color(nsColor: .secondaryLabelColor))
				textField
				if !text.isEmpty { clearButton }
			}
			.padding(.horizontal, 5)
			.padding(.vertical, 3)
			.background(focused ? .black : .clear)          // << here on focus !!
			.clipShape(RoundedRectangle(cornerRadius: 4))   // << clip to preserve shape !!
			.overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.gray, lineWidth: 0.5).cornerRadius(4)
			)
		}

		private var textField: some View {
			TextField(title, text: $text)
				.disableAutocorrection(true)
				.textFieldStyle(PlainTextFieldStyle())
				.focused($focused)
		}

		private var clearButton: some View {
			Button {
				self.text = ""
				// side-effect here if needed
			} label: {
				Image(systemName: "xmark.circle.fill")
			}
			.foregroundColor(.secondary)
			.buttonStyle(PlainButtonStyle())
		}
	}
}

struct TestBackgroundOfFocusedTextField_Previews: PreviewProvider {
	static var previews: some View {
		TestBackgroundOfFocusedTextField()
	}
}
