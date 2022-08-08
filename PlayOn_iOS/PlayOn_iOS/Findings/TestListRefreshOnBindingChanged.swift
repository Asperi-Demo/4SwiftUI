// 🔥BOYCOTT on russia - terrorist must be punished!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestListRefreshOnBindingChanged: View {
	var body: some View {
		ProfileView()
	}

	struct User: Identifiable, Equatable {
		let id = UUID()
		var name: String
		var isContacted = false
	}

	struct ProfileView: View {

		@State private var users = [
			User(name: "Taylor"),
			User(name: "Justin"),
			User(name: "Adele")
		]

		var body: some View {
			let _ = Self._printChanges()
			List($users) { $user in
				EquatableView(content: ProfileCell(user: $user))
			}
		}
	}

	struct ProfileCell: View, Equatable {
		static func == (lhs: ProfileCell, rhs: ProfileCell) -> Bool {
			lhs.user == rhs.user
		}

		@Binding var user: User
		var body: some View{
			let _ = Self._printChanges()
			Text(user.name + (user.isContacted ? "+" : ""))
			Spacer()
			Toggle("User has been contacted", isOn: $user.isContacted)
				.labelsHidden()
		}
	}
}

struct TestListRefreshOnBindingChanged_Previews: PreviewProvider {
	static var previews: some View {
		TestListRefreshOnBindingChanged()
	}
}
