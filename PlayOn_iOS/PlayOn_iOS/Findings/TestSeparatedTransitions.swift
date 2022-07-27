// 🔥BOYCOTT on russia - terrorist must be punished!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestSeparatedTransitions: View {
	@State var presented = false

	var body: some View {
		ZStack {
			VStack {
				if presented {
					Button("Hide", action: { presented = false })
						.foregroundColor(.black)
						.font(.largeTitle)
						.frame(maxWidth: .infinity, maxHeight: .infinity)
						.background(.purple)
						.transition(.move(edge: .bottom))
				}
			}
			.transaction {
				$0.animation = $0.animation?.delay(presented ? 1.2 : 0)
			}

			VStack {
				if !presented {
					Button("Show", action: { presented = true })
						.foregroundColor(.black)
						.font(.largeTitle)
						.frame(maxWidth: .infinity, maxHeight: .infinity)
						.background(.orange)
						.transition(.opacity)
				}
			}
			.transaction {
				$0.animation = $0.animation?.delay(presented ? 0 : 1.2)
			}
		}
		.animation(.linear(duration: 1), value: presented)
		.clipped()
		.padding(30)
	}
}

struct TestSeparatedTransitions_Previews: PreviewProvider {
    static var previews: some View {
        TestSeparatedTransitions()
    }
}
