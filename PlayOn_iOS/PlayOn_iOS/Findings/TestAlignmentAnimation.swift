// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestAlignmentAnimation: View {
	@State private var isAnimating = false

	var body: some View {
		Image(systemName: "globe")
			.resizable()
			.scaledToFit()
			.frame(maxHeight: .infinity, alignment: isAnimating ? .top : .bottom)
			.animation(Animation.easeInOut(duration: 5.0).repeatForever(autoreverses: true), value: isAnimating)

			.onAppear {
				isAnimating = true
			}
	}
}

struct TestAlignmentAnimation_Previews: PreviewProvider {
    static var previews: some View {
        TestAlignmentAnimation()
    }
}
