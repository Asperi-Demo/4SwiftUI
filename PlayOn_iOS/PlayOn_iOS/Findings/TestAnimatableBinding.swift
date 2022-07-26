// 🔥BOYCOTT on russia - terrorist must be punished!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestAnimatableBinding: View {
	struct SomeAnimatableView: View {
		var percent: Double

		var body: some View {
			GeometryReader { geo in
				ZStack {
					Rectangle()
						.fill(Color.blue)
						.frame(height: 120)
				Rectangle()
					.fill(Color.red)
					.frame(width: geo.size.width * percent, height: 116)
				}
				.frame(width: geo.size.width, height: geo.size.height)
			}
		}
	}

	struct ProgressRectangle: View {
		@Binding var percent: Double

		var body: some View {
			SomeAnimatableView(percent: percent)
				.onTapGesture {
					withAnimation(_percent.transaction.animation) {
						self.percent = 0 == self.percent ? 0.8 : 0
					}
				}
		}
	}

	@State var percent: Double = 0
	@State var isOn = false

	let animation = Animation.easeInOut

	var body: some View {
		VStack {
			// $percent.animation(.easeInOut)     // << does not work here if not changed internally!!
			// it is not transferred to source of truth
			ProgressRectangle(percent: $percent.animation())

//			SomeAnimatableView(percent: isOn ? 0.8 : 0.0)
//			Toggle("Test", isOn: $isOn.animation(animation)) // << works here !!
// Binding.animation is transferred to internal modifer so modification is performed
// with animation like below explicitly
		}
//		.onTapGesture {
//			withAnimation(animation) {  // << needs this one !!
//				self.percent = 0 == self.percent ? 0.8 : 0
//			}
//		}
	}
}

struct TestAnimatableBinding_Previews: PreviewProvider {
	static var previews: some View {
		TestAnimatableBinding()
	}
}
