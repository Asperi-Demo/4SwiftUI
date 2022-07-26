// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestExternalInternalFocusState: View {
	var body: some View {
		ContentView()
	}

	private enum FocusedField: String {
		case first
		case second
		case third
	}

	struct MyCustomTextField: View {
		@Binding var text: String
		@FocusState var isFocused

		var body: some View {
			TextField("", text: $text)
				.focused($isFocused)
				.padding()
				.background(
					Rectangle()
						.fill(isFocused ? Color.blue : Color.gray)
						.frame(maxWidth: .infinity, minHeight: 2, maxHeight: 2)
						.padding(.horizontal)
					, alignment: .bottom)
		}
	}

	struct ContentView: View {
		@State private var value = ""
		@FocusState private var focusedField: FocusedField?

		var body: some View {
			VStack {
				Button("Force") { focusedField = .first }
				Text("Selected: \(focusedField?.rawValue ?? "none")")
					.onAppear { DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {focusedField = FocusedField.second }}
				MyCustomTextField(text: $value)
					.focused($focusedField, equals: FocusedField.first)
				MyCustomTextField(text: $value)
					.focused($focusedField, equals: FocusedField.second)
			}
		}
	}
}

struct TestExternalInternalFocusState_Previews: PreviewProvider {
	static var previews: some View {
		TestExternalInternalFocusState()
	}
}
