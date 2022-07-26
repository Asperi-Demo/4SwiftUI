// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestArcAnimation: View {
	var body: some View {
		TestAnimation()
	}

	struct TestAnimation: View {

		@State var value: CGFloat = 0.2

		var body: some View {
			VStack {
				Arc(value: $value)
				Button(action: { self.value += 0.1 }) {
					Text("Increment")
				}
			}
		}
	}

	struct Arc: View {

		@Binding var value: CGFloat

		var body: some View {
			ArcShape(value: value)
				.stroke(lineWidth: 3)
				.animation(.easeOut(duration:2), value: value)
		}
	}


	struct ArcShape : Shape {

		var animatableData: CGFloat {
			get { value }
			set { value = newValue }
		}

		var value: CGFloat

		func path(in rect: CGRect) -> Path {
			var p = Path()
			let arcDegrees: Double = max(360.0 * Double(value), 2.0)
			let endAngle = -90.0 + arcDegrees
			p.addArc(center: CGPoint(x: rect.midX, y:rect.midY), radius: rect.height / 2, startAngle: .degrees(-90), endAngle: .degrees(endAngle), clockwise: false)
			return p
		}
	}

}

struct TestArcAnimation_Previews: PreviewProvider {
	static var previews: some View {
		TestArcAnimation()
	}
}
