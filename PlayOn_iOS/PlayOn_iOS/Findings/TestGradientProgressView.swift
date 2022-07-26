// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestGradientProgressView: View {
	var body: some View {
		GradientProgressView()
			.frame(height: 24)
			.padding(.horizontal)
	}

	struct GradientProgressView: View, Animatable {
		// gradient colors should be ordered so position cannot be less
		// then first color in gradient and more then last color in gradient
		@State private var animate = CGFloat(0.1)  // << left prgress position !!

		var body: some View {
			RoundedRectangle(cornerRadius: 12).fill(.clear)
				.modifier(GradientProgressEffect(position: animate))
				.clipShape(RoundedRectangle(cornerRadius: 12))
				.animation(.linear(duration: 2.0)
					.repeatForever(autoreverses: true), value: animate)
				.onAppear {
					animate = 0.9   // << right progress position !!
				}
		}

		struct GradientProgressEffect: AnimatableModifier {
			var position: CGFloat = 0

			var animatableData: CGFloat {
				get {
					position
				} set {
					position = newValue
				}
			}

			func body(content: Content) -> some View {
				content.background(
					LinearGradient(
						stops: [
							.init(color: .gray.opacity(0.1), location: 0.0),
							.init(color: .gray.opacity(1), location: position - 0.05),
							.init(color: .gray.opacity(1), location: position + 0.05),
							.init(color: .gray.opacity(0.1), location: 1.0),
						],
						startPoint: .leading,
						endPoint: .trailing
					)
					// we need gradient wider than holder to avoid jaming at edges
					.padding(.horizontal, -40)
					.clipped()
				)
			}
		}
	}
}

struct TestGradientProgressView_Previews: PreviewProvider {
	static var previews: some View {
		TestGradientProgressView()
	}
}
