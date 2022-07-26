// 🔥BOYCOTT on russia - terrorist must be punished!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestColorProgressOnStart: View {
	@State private var value = 0.8

	var body: some View {
		VStack {
			Button("Next") {
				value = [0.2, 0.8, 0.5, 0.7, 0.3, 0.6, 0.9].randomElement()!
			}
			ColorProgress(currentProgress: value)
		}
	}

	struct ColorProgress: View {
		@State private var fraction: CGFloat = 0
		var currentProgress: CGFloat

		var body: some View {
			ZStack(alignment: .leading) {
				RoundedRectangle(cornerRadius: 20)
					.foregroundColor(.gray)
					.frame(width: 300, height: 20, alignment: .center)
				RoundedRectangle(cornerRadius: 20)
					.foregroundColor(Color(red: min(2.0 - (fraction * 2.0), 1.0), green: min((fraction * 2.0), 1.0), blue: 0))
					.frame(width: 300 * fraction, height: 20)
			}
			.animation(.easeInOut(duration: 1.0), value: fraction)
			.onAppear {
				fraction = currentProgress
			}
			.onChange(of: currentProgress) {
				fraction = $0
			}
		}
	}
}

struct TestColorProgressOnStart_Previews: PreviewProvider {
	static var previews: some View {
		TestColorProgressOnStart()
	}
}
