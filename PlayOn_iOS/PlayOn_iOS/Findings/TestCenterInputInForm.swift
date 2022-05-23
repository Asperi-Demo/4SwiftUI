// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: 	By using this you agree do not repost any part of this code
//					on StackOverflow site. Thanks, Asperi.

import SwiftUI

struct TestCenterInputInForm: View {
	var body: some View {
		FormCenteredSection()
	}

	struct FormCenteredSection: View {
		@Environment(\.defaultMinListRowHeight) var rowHeight

		@State var username: String = ""
		@State var password: String = ""

		@State private var topInset: CGFloat?
		var body: some View {
			GeometryReader { gp in
				Form {
					Section {
						TextField("Username", text: $username)
						TextField("Password", text: $password)
					}
				header: {
					Color.clear
						.frame(height: gp.size.height/2 - rowHeight * 2.5)
				}
				}
			}
		}
	}
}

struct TestCenterInputInForm_Previews: PreviewProvider {
	static var previews: some View {
		TestCenterInputInForm()
	}
}
