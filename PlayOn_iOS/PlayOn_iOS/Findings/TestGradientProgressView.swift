// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: 	By using this you agree do not repost any part of this code
//					on StackOverflow site. Thanks, Asperi.

import SwiftUI

struct TestGradientProgressView: View {
	var body: some View {
		GradientProgressView()
			.frame(height: 24)
			.padding(.horizontal)
	}

	struct GradientProgressView: View, Animatable {
		@State private var animate = CGFloat(0.1)

		var body: some View {
			RoundedRectangle(cornerRadius: 12).fill(.clear)
				.modifier(GradientProgressEffect(position: animate))
				.clipShape(RoundedRectangle(cornerRadius: 12))
				.animation(.linear(duration: 2.0)
					.repeatForever(autoreverses: true), value: animate)
				.onAppear {
					animate = 0.9
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
					// we need it wider to avoid jam and boundary
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
