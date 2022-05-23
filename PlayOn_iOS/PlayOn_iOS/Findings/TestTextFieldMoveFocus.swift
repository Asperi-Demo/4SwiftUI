// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: 	By using this you agree do not repost any part of this code
//					on StackOverflow site. Thanks, Asperi.

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
