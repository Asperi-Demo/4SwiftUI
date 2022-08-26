// 🔥BOYCOTT on russia - terrorist must be punished!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestAlternateDestinations: View {
	@State private var isLongPressed = false
	
	var body: some View {
		NavigationView {
			NavigationLink(self.isLongPressed ? "Link2" : "Link1") {
				if isLongPressed {
					Destination2()
				} else {
					Destination1()
				}
			}
			.simultaneousGesture(LongPressGesture().onEnded { _ in
				self.isLongPressed.toggle()
			})
			.onAppear { isLongPressed = false }
		}
	}
	
	struct Destination1: View {
		var body: some View {
			Text("Destination1")
		}
	}
	
	struct Destination2: View {
		var body: some View {
			Text("Destination2")
		}
	}
}

struct TestAlternateDestinations_Previews: PreviewProvider {
	static var previews: some View {
		TestAlternateDestinations()
	}
}
