// 🔥BOYCOTT on russia - terrorist must be punished!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestDismissAffectsView: View {
	var body: some View {
		NavigationView {
			NavigationLink {
				DismissListView()
			} label: {
				Text("Go to see the list")
			}
		}
	}

	struct DismissListView: View {

		enum Field: Hashable {
			case line(Int)
		}

		@FocusState private var focus: Field?
		@State private var text: String = ""

		struct DismissView: View {
			@Environment(\.dismiss) private var dismiss

			var body: some View {
				Button("Dismiss me") {
					dismiss()
				}
			}
		}

		var body: some View {
			ScrollViewReader { proxy in
				List {
					let _ = print("body is rebuilding")

					DismissView()

					Section("Section") {
						ForEach((1...100), id: \.self) {num in
							TextField("text", text: $text)
								.id(Field.line(num))
								.focused($focus, equals: .line(num))
						}
					}
				}
				.listStyle(.insetGrouped)
				.onChange(of: focus) {_ in
					withAnimation {
						proxy.scrollTo(focus, anchor: .center)
					}
				}
			}
		}
	}

}

struct TestDismissAffectsView_Previews: PreviewProvider {
	static var previews: some View {
		TestDismissAffectsView()
	}
}
