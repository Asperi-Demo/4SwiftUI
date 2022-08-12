// 🔥BOYCOTT on russia - terrorist must be punished!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestPieProgress: View {
	@State private var progress: Float = 0

	var body: some View {
		VStack(spacing:20) {
			HStack{
				Text("0%")
				Slider(value: self.$progress)
				Text("100%")
			}.padding()
			PieProgress(progress: $progress)
				.padding()
		}
		.onAppear {
			DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
				self.progress = 0.72
			}
		}
	}

	struct PieProgress: View {
		@Binding var progress: Float

		var body: some View {
			Circle()
				.stroke(Color.gray, lineWidth: 1)
				.overlay(
					PieShape(progress: Double(self.progress))
						.padding(4)
						.foregroundColor(.blue)
				)
				.frame(maxWidth: .infinity)
				.animation(Animation.linear, value: progress) // << here !!
				.aspectRatio(contentMode: .fit)
		}
	}

	struct PieShape: Shape {
		var progress: Double = 0.0

		var animatableData: Double {
			get {
				self.progress
			}
			set {
				self.progress = newValue
			}
		}

		private let startAngle: Double = (Double.pi) * 1.5
		private var endAngle: Double {
			get {
				return self.startAngle + Double.pi * 2 * self.progress
			}
		}

		func path(in rect: CGRect) -> Path {
			var path = Path()
			let arcCenter =  CGPoint(x: rect.size.width / 2, y: rect.size.width / 2)
			let radius = rect.size.width / 2
			path.move(to: arcCenter)
			path.addArc(center: arcCenter, radius: radius, startAngle: Angle(radians: startAngle), endAngle: Angle(radians: endAngle), clockwise: false)
			path.closeSubpath()
			return path
		}
	}

}

struct TestPieProgress_Previews: PreviewProvider {
	static var previews: some View {
		TestPieProgress()
	}
}
