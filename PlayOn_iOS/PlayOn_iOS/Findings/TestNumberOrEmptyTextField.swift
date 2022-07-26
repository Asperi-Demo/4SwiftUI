// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestNumberOrEmptyTextField: View {
    var body: some View {
        ContentView()
    }

	struct ContentView: View {
		var body: some View {
			VStack {
				Text("Entered: " + (phoneNumber != nil ? "\(phoneNumber!)" : ""))
				TextField("Phone Number", value: Binding(
					get: { phoneNumber ?? 0},
					set: { phoneNumber = phoneNumber == $0 ? nil : $0 }
					), formatter: numberFormatter)
				.disableAutocorrection(true)
				.autocapitalization(.none)
				.textFieldStyle(RoundedBorderTextFieldStyle())
			}
		}

		@State private var numberFormatter: NumberFormatter = {
			var nf = NumberFormatter()
			nf.numberStyle = .none
			nf.zeroSymbol = ""
			return nf
		}()
		@State var phoneNumber: Int? = nil
	}
}

struct TestNumberOrEmptyTextField_Previews: PreviewProvider {
    static var previews: some View {
        TestNumberOrEmptyTextField()
    }
}
