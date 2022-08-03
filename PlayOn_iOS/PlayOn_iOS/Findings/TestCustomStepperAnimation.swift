// 🔥BOYCOTT on russia - terrorist must be punished!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestCustomStepperAnimation: View {
	@State private var currentIndex: Int = 1

	var body: some View {
		VStack(spacing: 32) {
			Stepper(withTotal: 8, andCurrentIndex: $currentIndex.animation(.default))
			Button(action: {
				currentIndex += 1
			}, label: {
				Text("INCREMENT")
			})
			Button(action: {
				currentIndex -= 1
			}, label: {
				Text("DECREMENT")
			})
		}
	}

	struct Stepper: View {
		@Binding var currentIndex: Int
		var total: Int

		var body: some View {
			ZStack(alignment: .center) {
				ZStack(alignment: .leading) {
					Color.gray.opacity(0.4)
					Color.blue
						.frame(width: 175.5 / CGFloat(total) * CGFloat(currentIndex))
				}
				.frame(width: 175.5, height: 2)
				.animation(_currentIndex.transaction.animation, value: currentIndex)     // << here !!
				Text("\(currentIndex)")
					.foregroundColor(.black)
					.offset(x: -113)
				Text("\(total)")
					.foregroundColor(.black)
					.offset(x: 113)
			}
			.frame(maxWidth: .infinity, maxHeight: 18)
		}

		init(withTotal total: Int,
			 andCurrentIndex currentIndex: Binding<Int>) {
			self._currentIndex = currentIndex
			self.total = total
		}
	}

}

struct TestCustomStepperAnimation_Previews: PreviewProvider {
	static var previews: some View {
		TestCustomStepperAnimation()
	}
}
