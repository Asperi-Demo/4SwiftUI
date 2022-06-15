// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: 	By using this you agree do not repost any part of this code
//					on StackOverflow site. Thanks, Asperi.

import SwiftUI

struct TestEditModeInForm: View {
	var body: some View {
		ContentView()
	}

	struct ContentView: View {

		var body: some View {
			NavigationView {
				Form {
					InternalView()
				}
				.toolbar {
					EditButton()
				}
			}
		}
	}
	struct InternalView: View {
		@Environment(\.editMode) private var editMode
		@State private var name = "Maria Ruiz"

		var body: some View {
			VStack {
				if editMode?.wrappedValue.isEditing == true {
					TextField("Name", text: $name)
				} else {
					Text(name)
				}
			}
			.animation(nil, value: editMode?.wrappedValue)
		}
	}
}

struct TestEditModeInForm_Previews: PreviewProvider {
	static var previews: some View {
		TestEditModeInForm()
	}
}
