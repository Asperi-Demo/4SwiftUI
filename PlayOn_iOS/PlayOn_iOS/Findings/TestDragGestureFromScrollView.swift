// 🔥BOYCOTT on russia - terrorist must be punished!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestDragGestureFromScrollView: View {
	struct Selection: Equatable {
		let index: Int
		let location: CGPoint
	}

	@State private var selection: Selection?

	var body: some View {
		GeometryReader { gr in

			ZStack {

				Color.blue.opacity(0.3)
					.aspectRatio(1, contentMode: .fit)
					.frame(width: gr.size.width)
					.overlay(GeometryReader { gp in

						if let current = selection, gp.frame(in: .named("demo")).contains(current.location) {
							Text("\(current.index)").bold().font(.largeTitle)
								.frame(maxWidth: .infinity, maxHeight: .infinity)
								.border(.primary)
								.padding()
						}
					})
					.onTapGesture {
						selection = nil
					}

				VStack {
					Spacer()
					ScrollView(.horizontal) {
						HStack {
							ForEach(1...15, id: \.self) { (idx) in
								Element(selection: $selection, index: idx)
							}
						}
						.padding()
						.background(ScrollViewConfigurator {
							$0?.clipsToBounds = false              // << here !!
						})
					}
					.background(Color.secondary.opacity(0.3))
				}
			}
		}
		.coordinateSpace(name: "demo")  // << common area !!
	}

	struct Element: View {
		@Binding var selection: Selection?
		@State private var dragAmount = CGSize.zero

		var index: Int

		var body: some View {
			Rectangle().fill(.secondary)
				.frame(width: 80, height: 80)
				.overlay(Text("\(index)").bold().foregroundColor(.primary))
				.offset(dragAmount)
				.gesture(
					DragGesture(coordinateSpace: .named("demo"))
						.onChanged {
							if abs($0.translation.height) > abs($0.translation.width) || self.dragAmount != .zero {
								self.dragAmount = CGSize(width: $0.translation.width, height: $0.translation.height)
								self.selection = Selection(index: index, location: $0.location)
							}
						}
						.onEnded { _ in
							self.dragAmount = .zero
						}
				)
		}
	}
}


struct DragGestureFromScrollView_Previews: PreviewProvider {
	static var previews: some View {
		TestDragGestureFromScrollView()
	}
}
