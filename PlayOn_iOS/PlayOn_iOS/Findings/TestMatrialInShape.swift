// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestMatrialInShape: View {
	var body: some View {
		ContentView()
	}

	struct ContentView: View {
		var body: some View {
			Image("background").overlay(
				Rectangle()
					.background(.thinMaterial)
					.frame(height: 200)
					.clipShape(CustomShape())
			)
		}
	}

	struct CustomShape: Shape {
		func path(in rect: CGRect) -> Path {
			var path = Path()

			path.move(to: CGPoint(x: rect.minX, y: rect.maxY))
			path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
			path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY + 25))
			path.addQuadCurve(to: CGPoint(x: 0, y: rect.minY + 25), control: CGPoint(x: rect.midX, y: rect.minY))
			path.closeSubpath()
			return path
		}
	}
}

struct TestMatrialInShape_Previews: PreviewProvider {
	static var previews: some View {
		TestMatrialInShape()
	}
}
