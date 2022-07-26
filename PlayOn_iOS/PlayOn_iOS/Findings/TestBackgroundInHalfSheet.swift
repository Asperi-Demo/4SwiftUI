// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestBackgroundInHalfSheet: View {
	var body: some View {
		DrawerViewPreviews()
	}

	fileprivate enum Constants {
		static let radius: CGFloat = 16
		static let indicatorHeight: CGFloat = 6
		static let indicatorWidth: CGFloat = 60
		static let snapRatio: CGFloat = 0.25
		static let minHeightRatio: CGFloat = 0
	}

	struct DrawerView<Content: View>: View {
		@Binding var isOpen: Bool

		let maxHeight: CGFloat
		//    let heightRatio: CGFloat
		let minHeight: CGFloat
		let content: Content

		@GestureState private var translation: CGFloat = 0

		private var offset: CGFloat {
			isOpen ? 0 : maxHeight - minHeight + 100
		}

		private var indicator: some View {
			RoundedRectangle(cornerRadius: Constants.radius)
				.fill(.gray)
				.frame(
					width: Constants.indicatorWidth,
					height: Constants.indicatorHeight
				).onTapGesture {
					self.isOpen.toggle()
				}
		}

		init(isOpen: Binding<Bool>, maxHeight: CGFloat, @ViewBuilder content: () -> Content) {
			self.minHeight = maxHeight * Constants.minHeightRatio
			self.maxHeight = maxHeight
			self.content = content()
			self._isOpen = isOpen
		}

		var body: some View {
			GeometryReader { geometry in
				VStack() {
					self.content
				}
				.padding(.vertical, 34)
				.padding(.horizontal, 16)
				.frame(width: geometry.size.width, height: self.maxHeight, alignment: .top)
				.background(
					RoundedRectangle(cornerRadius: Constants.radius).fill(.white)
						.edgesIgnoringSafeArea([.bottom, .horizontal])
				)
				.frame(height: geometry.size.height, alignment: .bottom)
				.offset(y: max(self.offset + self.translation, 0))
				.animation(.interactiveSpring(), value: offset)
				.gesture(
					DragGesture().updating(self.$translation) { value, state, _ in
						state = value.translation.height
					}.onEnded { value in
						let snapDistance = self.maxHeight * Constants.snapRatio
						guard abs(value.translation.height) > snapDistance else {
							return
						}
						self.isOpen = value.translation.height < 0
					}
				)
			}
			.shadow(color: Color(hue: 1.0, saturation: 0.0, brightness: 0.0, opacity: 0.08), radius: 12, y: -8)
		}
	}

	struct DrawerViewPreviews: View {
		@State private var isOpen = false
		var body: some View {
			ZStack {
				Color.black
					.ignoresSafeArea()

				VStack {
					Text("Main content")
						.font(.title)
						.foregroundColor(.white)
						.padding()
						.onTapGesture {
							isOpen = true
						}

					Rectangle()
						.fill(.white.opacity(0.16))
						.frame(maxWidth: .infinity)
						.frame(height: 300)

					Spacer()

				}
				.padding()

				DrawerView(isOpen: $isOpen, maxHeight: 300) {
					Text("Sheet Title")
						.font(.title)
					TextField("Placeholder", text: .constant("Tap Here"))
					Button("Submit") {}
				}
			}

		}
	}

}

struct TestBackgroundInHalfSheet_Previews: PreviewProvider {
	static var previews: some View {
		TestBackgroundInHalfSheet()
	}
}
