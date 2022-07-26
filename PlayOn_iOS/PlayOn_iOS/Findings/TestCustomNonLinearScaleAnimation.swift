// 🔥BOYCOTT on russia - terrorist must be punished!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestCustomNonLinearScaleAnimation: View {
	@State private var isPressed: Bool = false

	var body: some View {
		DotsView(
			diameter: 200,
			isPressed: isPressed
		)
		.frame(width: 500, height: 500)
		.simultaneousGesture(
			DragGesture(minimumDistance: 0)
				.onChanged { _ in
					isPressed = true
				}
				.onEnded { _ in
					isPressed = false
				}
		)
	}

	struct DotsView: View {
		var diameter: CGFloat = 200
		var size: CGFloat = 25
		var isPressed: Bool = false
		@State private var scaleImage : CGFloat = 1

		var body: some View {
			ZStack {
				ForEach(0...5, id: \.self) { i in
					Circle()
						.fill(Color.blue)
						.frame(width: size, height: size)
						.offset(x: 0, y: -(diameter)/2 - size/2)
						.rotationEffect(.degrees(CGFloat(i * 60)))
				}
			}
			.frame(width: diameter, height: diameter)
			.animation(.none, value: isPressed)
			.modifier(JumpyEffect(offset: isPressed ? 0.3 : 0, value: isPressed ? 0.8 : 1))
			.animation(
				isPressed ? .easeOut(duration: 0.2) : .interactiveSpring(response: 0.35, dampingFraction: 0.2),
				value: isPressed
			)
			.background(
				Circle()
					.fill(Color.green)
					.scaleEffect(isPressed ? 0.8 : 1)
					.animation(isPressed ? .none : .interactiveSpring(response: 0.35, dampingFraction: 0.2), value: isPressed)
			)
			.onChange(of: isPressed) {
				scaleImage = $0 ? 1.2 : 1
			}

		}
	}

	struct JumpyEffect: GeometryEffect {
		let offset: Double
		var value: Double

		var animatableData: Double {
			get { value }
			set { value = newValue }
		}

		func effectValue(size: CGSize) -> ProjectionTransform {
			// needed quick falling function that initial grow would be
			// deminished down to zero to end of animation (find better - just for demo)
			let trans = (value + offset * (pow(5, value - 1/pow(value, 5))))
			
			let transform = CGAffineTransform(translationX: size.width * 0.5, y: size.height * 0.5)
				.scaledBy(x: trans, y: trans)
				.translatedBy(x: -size.width * 0.5, y: -size.height * 0.5)
			return ProjectionTransform(transform)
		}
	}
}

struct TestCustomNonLinearScaleAnimation_Previews: PreviewProvider {
	static var previews: some View {
		TestCustomNonLinearScaleAnimation()
	}
}
