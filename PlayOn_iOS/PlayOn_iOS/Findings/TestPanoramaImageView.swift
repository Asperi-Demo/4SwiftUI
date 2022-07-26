// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestPanoramaImageView: View {
	var body: some View {
		ContentView()
	}

	struct ContentView: View {
		let panorama = UIImage(contentsOfFile: Bundle.main.path(forResource: "panorama", ofType: "jpeg")!)!
		var body: some View {
			PanoramaView(image: panorama)
				.frame(height: 300)   // to demo of dynamic internal layout
		}
	}

	struct PanoramaView: View {
		let image: UIImage

		private struct Item: Identifiable, Equatable {
			let id = UUID()
			var pos: CGFloat!
		}

		@State private var items = [Item(), Item()]
		@State private var gpSize = CGSize.zero
		@State private var needsSwap = false

		@GestureState private var dragOffset = CGFloat.zero
		private var scrollGesture: some Gesture {
			DragGesture()
				.updating($dragOffset) { value, state, _ in
					validateLayout(value.predictedEndTranslation.width)
					state = value.translation.width
				}
				.onEnded { value in
					validateLayout(value.predictedEndTranslation.width)
					let off = value.translation.width
					items = items.map {
						var v = $0; v.pos += off; return v
					}
					withAnimation(.easeOut) {
						let dif = value.predictedEndTranslation.width - off
						items = items.map {
							var v = $0; v.pos += dif; return v
						}
					}
				}
		}

		var body: some View {
			GeometryReader { gp in
				let centerY = gp.size.height / 2
				ForEach($items) { $item in
					Image(uiImage: image)
						.resizable().aspectRatio(contentMode: .fill)
						.position(x: item.pos ?? 0, y: centerY)
						.offset(x: dragOffset)
				}
			}
			.background(GeometryReader {
				Color.clear.preference(key: ViewSizeKey.self,
									   value: $0.frame(in: .local).size)
			})
			.onPreferenceChange(ViewSizeKey.self) {
				setupLayout($0)
			}
			.contentShape(Rectangle())
			.gesture(scrollGesture)
		}

		private func setupLayout(_ gpSize: CGSize) {
			self.gpSize = gpSize

			guard items.first?.pos == nil else { return }

			let size = image.size
			let width = size.width * gpSize.height / size.height

			self.items[0].pos = 0
			self.items[1].pos = width - 0.5
		}

		private func validateLayout(_ offset: CGFloat) {
			let size = image.size
			let width = size.width * gpSize.height / size.height
			if items[0].pos + offset > width / 2.0 {
				DispatchQueue.main.async {
					items[1].pos = items[0].pos - width + 0.5
					items.insert(items[1], at: 0)
					items.removeLast()
				}
			}
			else if items[0].pos + offset < -width {
				DispatchQueue.main.async {
					items[0].pos = items[1].pos + width - 0.5
					items.append(items[0])
					items.removeFirst()
				}
			}
		}

	}

}

struct TestPanoramaImageView_Previews: PreviewProvider {
	static var previews: some View {
		TestPanoramaImageView()
	}
}
