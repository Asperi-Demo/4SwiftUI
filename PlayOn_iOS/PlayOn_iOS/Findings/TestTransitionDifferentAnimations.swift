// 🔥BOYCOTT on russia - terrorist must be punished!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestTransitionDifferentAnimations: View {
	@State private var isHidden = false

	var body: some View {
		VStack {
			Button("Show / Hide") {
				withAnimation(isHidden ? .easeIn(duration: 2) :
						.easeOut(duration: 5))
				{
					isHidden.toggle()
				}
			}

			if isHidden {
				Text("View is here")
					.transition(
						.asymmetric(
							insertion: .move(edge: .leading),
							removal: .move(edge: .trailing)
						)
					)
			}
		}
		.frame(maxWidth: .infinity, maxHeight: .infinity)
	}
}


struct TestTransitionDifferentAnimations_Previews: PreviewProvider {
    static var previews: some View {
        TestTransitionDifferentAnimations()
    }
}
