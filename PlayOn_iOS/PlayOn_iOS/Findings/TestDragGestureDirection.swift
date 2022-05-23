// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: 	By using this you agree do not repost any part of this code
//					on StackOverflow site. Thanks, Asperi.

import SwiftUI

struct TestDragGestureDirection: View {

	@State var current: CGFloat? = nil // << any initial
	@State var isUp = false
	@State var offsetY = CGFloat.zero

	var body: some View {
		GeometryReader { g in // << for top container height limit
			ZStack {
				Color.yellow

				Circle().fill(.blue).frame(width: 100)
					.offset(x: 0, y: offsetY)
					.gesture(DragGesture()
						.onChanged { value in
							let newValue = value.location.y
							if let prev = self.current {
								self.isUp = prev > newValue
							}
							self.current = newValue
							self.offsetY = value.translation.height
						}
						.onEnded { _ in
							self.current = nil
							self.offsetY = 0
						})

				if current != nil {
					Text(isUp ? "Up" : "Down")
				}

			}
		}
	}
}

struct TestDragGestureDirection_Previews: PreviewProvider {
    static var previews: some View {
        TestDragGestureDirection()
    }
}
