// 🔥BOYCOTT on russia - terrorist must be punished!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestRoutePathStrokeAnimate: View {

	struct Route: Shape {
		var points: [CGPoint]
		var head: CGPoint

		// make route animatable head position only
		var animatableData: AnimatablePair<CGFloat, CGFloat> {
			get { AnimatablePair(head.x, head.y) }
			set {
				head.x = newValue.first
				head.y = newValue.second
			}
		}

		func path(in rect: CGRect) -> Path {
			Path { path in
				guard points.count > 1 else { return }
				path.move(to: points.first!)
				_ = points.dropFirst().dropLast().map { path.addLine(to: $0) }
				path.addLine(to: head)
			}
		}
	}

	// Route view model holding all points and notifying when last one changed
	class RouteVM: ObservableObject {
		var points = [CGPoint.zero] {
			didSet {
				self.lastPoint = points.last ?? CGPoint.zero
			}
		}
		@Published var lastPoint = CGPoint.zero
	}

	@StateObject var vm = RouteVM()

	var body: some View {
		GeometryReader { gp in
			ZStack { // area
				Rectangle().fill(Color.white)
					.gesture(DragGesture(minimumDistance: 0).onEnded { value in
						self.vm.points.append(value.location) // read coordinates in area
					})

				Circle().fill(Color.blue).frame(width: 20)
					.position(self.vm.points.first!) // show initial point

				// draw route when head changed, animating
				Route(points: self.vm.points, head: self.vm.lastPoint)
					.stroke(style: StrokeStyle(lineWidth: 8, lineCap: .round, lineJoin: .miter, miterLimit: 0, dash: [], dashPhase: 0))
					.foregroundColor(.red)
					.animation(.linear(duration: 0.5), value: self.vm.lastPoint)
			}
			.onAppear {
				let area = gp.frame(in: .global)
				// just initail point at the bottom of screen
				self.vm.points = [CGPoint(x: area.midX, y: area.maxY)]
			}
		}.edgesIgnoringSafeArea(.all)
	}
}

struct TestRoutePathStrokeAnimate_Previews: PreviewProvider {
	static var previews: some View {
		TestRoutePathStrokeAnimate()
	}
}
