// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestSwitchSecureField: View {
	var body: some View {
		DemoShowPassword()
	}

	struct DemoShowPassword: View {
		@State private var showPassword: Bool = false
		@State private var password = ""
		@FocusState var inFocus: Field?

		enum Field {
			case secure, plain
		}

		var body: some View {
			VStack {
				Spacer()
				if showPassword {
					TextField("Enter Password", text: $password)
						.focused($inFocus, equals: .plain)
				} else {
					SecureField("Enter Password", text: $password)
						.focused($inFocus, equals: .secure)
				}
				Button("toggle") {
					self.showPassword.toggle()
					inFocus = showPassword ? .plain : .secure
				}
				Spacer()
			}.ignoresSafeArea(.keyboard, edges: .bottom)
		}
	}

}

struct TestSwitchSecureField_Previews: PreviewProvider {
	static var previews: some View {
		TestSwitchSecureField()
	}
}
