// 🔥BOYCOTT on russia - terrorist must be punished!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestShapeAnimationAlignment: View {
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                PlanetView()
                    .frame(width: geometry.size.width * 0.25, height: geometry.size.width * 0.25)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

struct PlanetView: View {
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Circle()
                    .fill(.blue)

                Circle()
                    .foregroundColor(.green)
                    .overlay(
                    	PlanetShadow()
                    		.fill(Color.black.opacity(0.25))
                    		.rotationEffect(.degrees(-30)))
                    .frame(width: geometry.size.width * 0.8, height: geometry.size.width * 0.8)
            }
        }
    }
}

struct PlanetShadow: Shape {
    var offsetRatio: CGFloat = 15/100.0

	func path(in rect: CGRect) -> Path {
		Path { path in
			path.move(to: CGPoint(x: 0, y: rect.size.height / 2))
			path.addCurve(to: CGPoint(x: rect.size.width, y: rect.size.height / 2),
						  control1: control1(rect.size),
						  control2: control2(rect.size))
			path.addArc(center: CGPoint(x: rect.size.width / 2, y: rect.size.height / 2),
						radius: rect.size.width / 2,
						startAngle: Angle(degrees: 0),
						endAngle: Angle(degrees: 180),
						clockwise: false)
			path.closeSubpath()
		}
	}

    func control1(_ size: CGSize) -> CGPoint {
        let xOffset = offsetRatio * size.width
        let yOffset = offsetRatio * size.height
        return .init(x: xOffset, y: size.height - yOffset)
    }

    func control2(_ size: CGSize) -> CGPoint {
        let xOffset = offsetRatio * size.width
        let yOffset = offsetRatio * size.height
        return .init(x: size.width - xOffset, y: size.height - yOffset)
    }
}

struct TestShapeAnimationAlignment_Previews: PreviewProvider {
    static var previews: some View {
        TestShapeAnimationAlignment()
    }
}
