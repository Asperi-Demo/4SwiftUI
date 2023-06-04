// 🔥BOYCOTT on russia - terrorist must be punished!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestSquareHoleView: View {
	@State private var rect: CGRect = CGRect(x: 100, y: 100, width: 200, height: 300)

	@Namespace var ns
	var body: some View {
		VStack {
			Button("Random") {
				let rects = [
					CGRect(x: 100, y: 100, width: 200, height: 300),
					CGRect(x: 0, y: 100, width: 400, height: 300),
					CGRect(x: 100, y: 0, width: 200, height: 600),
					CGRect(x: 0, y: 400, width: 400, height: 200),
					CGRect(x: 200, y: 200, width: 100, height: 400),
				]

				rect = rects.randomElement()!
			}
			Color.clear
				.overlay(
					Image("picture")
						.resizable()
						.aspectRatio(contentMode: .fill)
				)
				.overlay(
					RectHoleShape(rect: rect)
						.fill(style: FillStyle(eoFill: true))  // << here !!
						.animation(.linear, value: rect)
						.foregroundColor(.yellow)
				)
		}
	}
}

struct RectHoleShape: Shape, Animatable {
	var rect: CGRect

	// !! Main part is here !!
    var animatableData: AnimatablePair<AnimatablePair<CGFloat,CGFloat>, AnimatablePair<CGFloat,CGFloat>> {
        get { AnimatablePair(AnimatablePair(rect.origin.x, rect.origin.y), AnimatablePair(rect.size.width, rect.size.height)) }
        set {
            rect.origin.x = newValue.first.first
            rect.origin.y = newValue.first.second
            rect.size.width = newValue.second.first
            rect.size.height = newValue.second.second
		}
    }

	func path(in r: CGRect) -> Path {
		Path {
			$0.move(to: CGPoint(x: r.minX, y: r.minY))
			$0.addLine(to: CGPoint(x: r.maxX, y: r.minY))
			$0.addLine(to: CGPoint(x: r.maxX, y: r.maxY))
			$0.addLine(to: CGPoint(x: r.minX, y: r.maxY))
			$0.addLine(to: CGPoint(x: r.minX, y: r.minY))
			$0.closeSubpath()

			$0.move(to: CGPoint(x: rect.minX, y: rect.minY))
			$0.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
			$0.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
			$0.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
			$0.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
			$0.closeSubpath()
		}
	}
}

struct TestSquareHoleView_Previews: PreviewProvider {
    static var previews: some View {
        TestSquareHoleView()
    }
}
