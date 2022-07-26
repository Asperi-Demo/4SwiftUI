// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestTextFieldMoveFocus: View {
	@State private var firstname = ""
	@State private var lastname = ""

	@FocusState private var infocus: Field?

	enum Field {
		case first, last
	}

	var body: some View {
		VStack {
			NavigationView {
				Form {
					TextField("First name", text: $firstname, onCommit: { infocus = .last })
						.focused($infocus, equals: .first)

					TextField("Last name", text: $lastname)
						.focused($infocus, equals: .last)

				}
				.navigationBarTitle("Add a Person", displayMode: .inline)
			}
		}
	}
}

struct TestTextFieldMoveFocus_Previews: PreviewProvider {
    static var previews: some View {
        TestTextFieldMoveFocus()
    }
}
