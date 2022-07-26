// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestEmitterView: View {
	var body: some View {
		ContentView()
	}

	struct ContentView: View {

		@State var colors = [Color.white]
		var body: some View {
			ZStack {
				EmitterView(images: ["spark"], particleCount: 200, creationRange: CGSize(width: 0.4, height: 0.2), colors: colors, blendMode: .screen, angle: .degrees(0), angleRange: .degrees(360), opacityRange: 0, opacitySpeed: 15, scale: 0.5, scaleRange: 0.2, scaleSpeed: -0.2, speed: 50, speedRange: 120, animation: Animation.linear(duration: 1).repeatForever(autoreverses: false), animationDelayTreshold: 1)
					.ignoresSafeArea()
			}
			.background(.black)
			.edgesIgnoringSafeArea(.all)
			.statusBar(hidden: true)
			.onTapGesture {
				colors = [.red]
			}
		}
	}

	struct EmitterView: View {

		private struct ParticleView: View {

			let image: Image

			@State private var isActive = false
			let position: ParticleState<CGPoint>
			let opacity: ParticleState<Double>
			let rotation: ParticleState<Angle>
			let scale: ParticleState<CGFloat>

			var animation: Animation
			var delayTreshold = 0.0


			var body: some View {
				image
					.opacity(isActive ? opacity.end : opacity.start)
					.scaleEffect(isActive ? scale.end : scale.start)
					.rotationEffect(isActive ? rotation.end : rotation.start)
					.position(isActive ? position.end : position.start)
					.animation(self.animation.delay(Double.random(in: 0...self.delayTreshold)), value: isActive)
					.onAppear{self.isActive = true}
			}

		}

		private struct ParticleState<T> {
			var start: T
			var end: T

			init(_ start: T, _ end: T) {
				self.start = start
				self.end = end
			}
		}

		var images: [String]

		var particleCount: Int

		var creationPoint = UnitPoint.center
		var creationRange = CGSize.zero

		var colors = [Color.white]
		var blendMode = BlendMode.normal

		var angle = Angle.zero
		var angleRange = Angle.zero

		var opacity = 1.0
		var opacityRange = 0.0
		var opacitySpeed = 0.0

		var rotation = Angle.zero
		var rotationRange = Angle.zero
		var rotationSpeed = Angle.zero

		var scale: CGFloat = 1
		var scaleRange: CGFloat = 0
		var scaleSpeed: CGFloat = 0

		var speed = 0.0
		var speedRange = 0.0

		var animation = Animation.linear.repeatForever(autoreverses: false)
		var animationDelayTreshold = 0.0

		var body: some View {

			GeometryReader { geo in
				ZStack {
					ForEach(0..<self.particleCount, id: \.self) { i in

						ParticleView(
							image: Image(images.randomElement()!),
							position: self.position(in: geo),
							opacity: self.makeOpacity(),
							rotation: self.makeRotation(),
							scale: self.makeScale(),
							animation: animation,
							delayTreshold: animationDelayTreshold
						)
						.colorMultiply(self.colors.randomElement() ?? .white)
						.blendMode(self.blendMode)
					}
				}
			}
		}

		private func position(in proxy: GeometryProxy) -> ParticleState<CGPoint> {
			let halfCreationRangeWidth = creationRange.width / 2
			let halfCreationRangeHeight = creationRange.height / 2

			let creationOffsetX = CGFloat.random(in: -halfCreationRangeWidth...halfCreationRangeWidth)
			let creationOffsetY = CGFloat.random(in: -halfCreationRangeHeight...halfCreationRangeHeight)

			let startX = (proxy.size.width * (creationPoint.x + creationOffsetX))
			let startY = (proxy.size.height * (creationPoint.y + creationOffsetY))
			let start = CGPoint(x: startX, y: startY)

			let halfSpeedRange = speedRange / 2
			let actualSpeed  = Double.random(in: speed - halfSpeedRange...speed + halfSpeedRange)

			let halfAngleRange = angleRange.radians / 2
			let totalRange = Double.random(in: angle.radians - halfAngleRange...angle.radians + halfAngleRange)

			let finalX = cos(totalRange - .pi / 2) * actualSpeed
			let finalY = sin(totalRange - .pi / 2) * actualSpeed
			let end = CGPoint(x: Double(startX) + finalX, y: Double(startY) + finalY)

			return ParticleState(start, end)
		}

		private func makeOpacity() -> ParticleState<Double> {
			let halfOpacityRange = opacity / 2
			let randomOpacity = Double.random(in: -halfOpacityRange...halfOpacityRange)

			return ParticleState(opacity + randomOpacity, opacity + opacitySpeed + randomOpacity)
		}

		private func makeScale() -> ParticleState<CGFloat> {
			let halfScaleRange = scaleRange / 2
			let randomScale = CGFloat.random(in: -halfScaleRange...halfScaleRange)

			return ParticleState(scale + randomScale, scale + scaleSpeed + randomScale)
		}

		private func makeRotation() -> ParticleState<Angle> {
			let halfRotationRange = (rotationRange / 2).radians
			let randomRotation = Double.random(in: -halfRotationRange...halfRotationRange)
			let randomRotationAngle = Angle(radians: randomRotation)

			return ParticleState(rotation + randomRotationAngle, rotation + rotationSpeed + randomRotationAngle)
		}
	}

}

struct TestEmitterView_Previews: PreviewProvider {
	static var previews: some View {
		TestEmitterView()
	}
}
