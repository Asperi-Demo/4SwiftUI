// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

extension Int16: Identifiable {
	public var id: Self { self }
}

struct TestUnlimitedScrollView: View {

	struct Model: Identifiable, Equatable {
		let id = UUID()
		var val: String
		var pos: CGFloat?
	}

	@State var model = (0..<5).map { Model(val: "\($0)") }
	let data = (Int16.min...Int16.max).map { $0 }

	let onScreen = 5
	let space: CGFloat = 10
	let size: CGFloat = 100

	@State var offset: CGFloat = .zero
	@State var isSetup = false
	@State private var gp_width = CGFloat.zero

	var body: some View {
		GeometryReader { gp in
			let centerY = gp.size.height / 2
			ForEach(Array(model.enumerated()), id: \.1.id) { i, m in
				Cell(value: m.val)
					.position(x: m.pos ?? 0, y: centerY)
					.offset(x: offset)
			}
		}
		.background(GeometryReader {
			Color.clear.preference(key: ViewOffsetKey.self,
								   value: $0.frame(in: .local).size.width)
		})
		.onPreferenceChange(ViewOffsetKey.self) {
			setupLayout($0)
		}
		.contentShape(Rectangle())
		.highPriorityGesture(DragGesture()
			.onChanged { value in
				offset = value.translation.width
				verifyLayout(offset)
			}
			.onEnded { value in
				applyLayout(value.translation.width)
				offset = .zero
			}
		)
		.animation(.easeInOut, value: offset)
		.frame(height: size)
	}

	func processFirst() -> Bool {
		guard let m = model.first, let pos = m.pos else { return false }
		//			if pos + size/2.0 + offset + space/2.0 < 0 {
		if pos + offset + (size + space) < 0 {
			model.removeFirst()
			if let m1 = model.last {
				var m2 = Model(val: m.val)
				m2.pos = m1.pos! + size + space
				model.append(m2)
				return true
			}
		}
		return false
	}

	func processLast() -> Bool {
		guard let m = model.last, let pos = m.pos else { return false }
		//			if pos - size/2.0 + offset - space/2.0 > gp_width {
		if pos + offset - (size + space) > gp_width {
			model.removeLast()
			if let m1 = model.first {
				var m2 = Model(val: m.val)
				m2.pos = m1.pos! - (size + space)
				model.insert(m2, at: 0)
				return true
			}
		}
		return false
	}


	// !! instead of validating each side it is possible to increase
	// !! head and tail depending on speed without verification and
	// !! then at the end (or on slow down) just drop everything added
	func verifyLayout(_ offset: CGFloat) {
		//		print(">> \(offset)")
		if offset < 0 {
			repeat {
			} while processFirst()
		} else {
			repeat {
			} while processLast()
		}
	}

	func applyLayout(_ offset: CGFloat) {
		verifyLayout(offset)

		model = model.compactMap {
			var m = $0
			m.pos? += offset
			return m
		}
	}

	func setupLayout(_ gpWidth: CGFloat) {
		guard !isSetup else { return }

		let mid = onScreen / 2
		let midX = gpWidth / 2

		var m1 = model
		for i in model.indices {
			m1[i].pos = midX + CGFloat(i - mid)*(size + space)
		}

		model = m1
		isSetup = true
		gp_width = gpWidth
	}

	struct Cell: View {
		let size = CGFloat(100)
		let value: String
		init(value: String) {
			//			print(">>" + value)
			self.value = value
		}
		var body: some View {
			RoundedRectangle(cornerRadius: 12)
				.frame(width: size, height: size)
				.overlay(Text(value).foregroundColor(.white))
		}
	}
}


struct TestUnlimitedScrollView_Previews: PreviewProvider {
    static var previews: some View {
        TestUnlimitedScrollView()
    }
}
