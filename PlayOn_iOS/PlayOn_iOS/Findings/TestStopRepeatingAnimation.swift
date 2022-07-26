// 🔥BOYCOTT on russia - terrorist must be punished!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestStopRepeatingAnimation: View {
	@State private var start = false

	var body: some View {
		Button(start ? "Stop" : "Start")
			{ self.start.toggle() }
			.frame(maxWidth: 100)
			.font(.largeTitle)
			.padding()
			.foregroundColor(.white)
			.background(RoundedRectangle(cornerRadius: 10).fill(Color.green))
			.overlay(
				RoundedRectangle(cornerRadius: 10)
					.stroke(Color.green, lineWidth: 4)
					.scaleEffect(start ? 2 : 0.9)
					.opacity(start ? 0 : 1)
					.animation(start ? Animation.easeOut(duration: 0.6)
						.delay(1) // Add 1 second between animations
						.repeatForever(autoreverses: false) : .default, value: start)
			)
	}
}

struct TestStopRepeatingAnimation_Previews: PreviewProvider {
    static var previews: some View {
        TestStopRepeatingAnimation()
    }
}
