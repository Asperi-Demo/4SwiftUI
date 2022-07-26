// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestCycleClockAnimation: View {
	var body: some View {
		ContentView()
	}

	struct ContentView: View {
		@State var state: Bool = false

		var body: some View {
			VStack {
				CircleView(hoursOffset: CGFloat(state ? 6 : 0 ))
					.aspectRatio(contentMode: .fit)
					.padding()
				Toggle(isOn: $state, label: { Text("Rotate 180°?") })
					.frame(maxWidth: 200).padding()
			}
		}
	}

	struct CircleMoving: AnimatableModifier {
		var hoursOffset: CGFloat
		var hour: CGFloat
		var size: CGFloat

		public var animatableData: CGFloat {
			get { hoursOffset }
			set { self.hoursOffset = newValue }
		}

		func body(content: Content) -> some View {
			content
				.position(CGPoint.onCircle(hours: hour + hoursOffset, size: size))
		}
	}


	struct CircleView: View {

		var hoursOffset: CGFloat

		var body: some View {
			GeometryReader() { geo in
				ForEach(0..<12) { hour in
					ZStack {
						Text("\(hour)")
							.modifier(CircleMoving(hoursOffset: self.hoursOffset, hour: CGFloat(hour), size: geo.size.width))
					}
				}
			}
			.animation(.easeInOut(duration: 3.0), value: hoursOffset) // !!!
		}
	}

}

struct TestCycleClockAnimation_Previews: PreviewProvider {
	static var previews: some View {
		TestCycleClockAnimation()
	}
}
