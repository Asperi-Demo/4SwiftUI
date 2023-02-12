import SwiftUI

struct TestBlendDestinationOutAsMask: View {
	var body: some View {
		ZStack {
			Image("picture").aspectRatio(contentMode: .fill)

			ZStack {
				Color.red
				MyShape().fill().blendMode(.destinationOut) // << here !!
			}
			.compositingGroup()                             // << here !!
			.frame(width: 400, height: 300)
		}
	}

	struct MyShape: Shape {
		func path(in rect: CGRect) -> Path {
			var p = Path()

			//        p.addRect(rect)     // << remove this !!

			p.addRect(.init(origin: .init(x: 60, y: 60),
							size: .init(width: 100, height: 100)))

			p.addRect(.init(origin: .init(x: 120, y: 120),
							size: .init(width: 100, height: 100)))

			p.addRect(.init(origin: .zero,
							size: .init(width: 100, height: 100)))

			return p
		}
	}
}

struct TestBlendDestinationOutAsMask_Previews: PreviewProvider {
	static var previews: some View {
		TestBlendDestinationOutAsMask()
	}
}
