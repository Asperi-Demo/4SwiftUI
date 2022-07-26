// 🔥BOYCOTT on russia - terrorist must be punished!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestForDrawingGroupOnAnimation: View {
	var body: some View {
		MovingCirclesView()
	}

	struct MovingCirclesView: View {
		@State var animationPercent: Double = 0

		var body: some View {
			ZStack {
				MovingCircle(animationPercent: $animationPercent, size: 300, movementRadius: 100, startAngle: 0)
					.offset(x: -200, y: -200)

				MovingCircle(animationPercent: $animationPercent, size: 400, movementRadius: 120, startAngle: .pi * 3/4)
					.offset(x: 50, y: 300)

				MovingCircle(animationPercent: $animationPercent, size: 350, movementRadius: 200, startAngle: .pi * 5/4)
					.offset(x: 10, y: 30)

				MovingCircle(animationPercent: $animationPercent, size: 230, movementRadius: 80, startAngle: .pi * 1/2)
					.offset(x: 220, y: -300)

				MovingCircle(animationPercent: $animationPercent, size: 230, movementRadius: 150, startAngle: .pi)
					.offset(x: 220, y: 100)
			}.frame(maxWidth: .infinity, maxHeight: .infinity)
				.drawingGroup()
				.animation(Animation.linear(duration: 30).repeatForever(autoreverses: false), value: animationPercent)
				.onAppear() { self.animationPercent = 1 }
		}

		private struct MovingCircle: View, Animatable {
			@Binding var animationPercent: Double

			let size: CGFloat
			let movementRadius: CGFloat
			let startAngle: Double

			var body: some View {
				Circle()
					.frame(width: size, height: size)
					.foregroundColor(Color.white)
					.opacity(0.1)
					.offset(angle: .radians(.pi * 2 * self.animationPercent + self.startAngle), radius: self.movementRadius)
			}
		}
	}
}

fileprivate struct AngularOffset: AnimatableModifier {
	var angle: Angle
	var radius: CGFloat

	var animatableData: AnimatablePair<Double, CGFloat> {
		get {
			return AnimatablePair(angle.radians, radius)
		}
		set {
			self.angle = .radians(newValue.first)
			self.radius = newValue.second
		}
	}

	func body(content: Content) -> some View {
		return content.offset(CGSize(
			width: CGFloat(cos(self.angle.radians)) * self.radius,
			height: CGFloat(sin(self.angle.radians)) * self.radius
		))
	}
}

fileprivate extension View {
	func offset(angle: Angle, radius: CGFloat) -> some View {
		ModifiedContent(content: self, modifier: AngularOffset(angle: angle, radius: radius))
	}
}

struct TestForDrawingGroupOnAnimation_Previews: PreviewProvider {
	static var previews: some View {
		TestForDrawingGroupOnAnimation()
	}
}
