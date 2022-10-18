// 🔥BOYCOTT on russia - terrorist must be punished!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestContinuousAnimationStartStop: View {
	var body: some View {
		CirclePathProgressView()
	}

	struct CirclePathProgressView : View {
		@State private var isAnimating = false
		@State private var showProgress = false

		var foreverAnimation: Animation {
			Animation.linear(duration: 2.0)
				.repeatForever(autoreverses: false)
		}

		var body: some View {
			Button(action: { self.showProgress.toggle() }, label: {
				if showProgress {
					Image(systemName: "arrow.2.circlepath")
						.rotationEffect(Angle(degrees: self.isAnimating ? 360 : 0.0))
						.animation(self.isAnimating ? foreverAnimation : .default, value: isAnimating)
						.onAppear { self.isAnimating = true }
						.onDisappear { self.isAnimating = false }
				} else {
					Image(systemName: "arrow.2.circlepath")
				}
			})
			.onAppear { self.showProgress = true }
		}
	}
}

struct TestContinuousAnimationStartStop_Previews: PreviewProvider {
	static var previews: some View {
		TestContinuousAnimationStartStop()
	}
}
