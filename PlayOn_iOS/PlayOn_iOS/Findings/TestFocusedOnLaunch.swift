// 🔥BOYCOTT on russia - terrorist must be punished!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestFocusedOnLaunch: View {
	@State private var text = "BOYCOTT on russia!"

	enum Value: Hashable {
		case one
	}

	@Environment(\.scenePhase) var phase
	@FocusState var focused: Value?

	var body: some View {
		VStack {
			TextField("Placeholder", text: $text)
				.focused($focused, equals: .one)
				.onChange(of: phase) {
					if case .active = $0 {
						DispatchQueue.main.async {
							focused = .one		// << here !!
						}
					}
				}
				.onAppear {
//					DispatchQueue.main.async {
//						focused = .one // ❌ does not work at launch
//					}
				}

			Button {
				focused = .one
			} label: {
				Text("Force Focus")
			}
		}
	}
}

struct TestFocusedOnLaunch_Previews: PreviewProvider {
    static var previews: some View {
        TestFocusedOnLaunch()
    }
}
