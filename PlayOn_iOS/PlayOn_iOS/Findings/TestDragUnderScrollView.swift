// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestDragUnderScrollView: View {     // not stable !!
	@State private var offset: CGFloat = .zero
	@State private var isBlocked = false

	var body: some View {
		VStack {
			ScrollView {
				VStack {
					ForEach(0..<40) {
						Text("Row \($0)")
							.frame(maxWidth: .infinity, minHeight: 120)
							.background(RoundedRectangle(cornerRadius: 10).fill(.blue))
					}
				}
				.clipShape(Rectangle())
				.background(GeometryReader {
									 Color.clear.preference(key: ViewOffsetKey.self,
										  value: -$0.frame(in: .named("scroll")).origin.y)
								})
				.onPreferenceChange(ViewOffsetKey.self) {
					isBlocked = $0 < 0
					print("should block" + (isBlocked ? "[x]" : ""))
					print("offset >> \($0)")
				}
        }
        .border(.black)
			.coordinateSpace(name: "scroll")
		}
		.padding(40)
		.background(.yellow, ignoresSafeAreaEdges: .bottom)
		.offset(y: offset)
		.gesture(DragGesture(minimumDistance: 4, coordinateSpace: .global)
			.onChanged {
				let off = $0.translation.height
				if off > 0 {
					offset = off
				}
				print("<<<<< \(off)")
			}
			.onEnded{ _ in
				offset = .zero
			}
		, including: isBlocked ? .gesture : .all)
	}
}
struct TestDragUnderScrollView_Previews: PreviewProvider {
    static var previews: some View {
        TestDragUnderScrollView()
    }
}
