// 🔥BOYCOTT on russia - terrorist must be punished!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestFlexibleStickyHeader: View {
    @State var imageHeight: CGFloat = 0
    let headerHeight: CGFloat = 200

    var body: some View {
		ScrollView {
			// just remove .sectionHeaders to make it non-sticky
			LazyVStack(spacing: 8, pinnedViews: [.sectionHeaders]) {
				Section {
					// >> any content
					ForEach(0...100) {
						Text("Item \($0)")
							.frame(maxWidth: .infinity, minHeight: 60)
							.background(RoundedRectangle(cornerRadius: 12).fill($0%2 == 0 ? .blue : .yellow))
							.padding(.horizontal)
					}
					// << content end
				} header: {
					// here is only caculable part
					GeometryReader {
						// detect current position of header bottom edge
						Color.clear.preference(key: ViewOffsetKey.self,
							value: $0.frame(in: .named("area")).maxY)
					}
					.frame(height: headerHeight)
					.onPreferenceChange(ViewOffsetKey.self) {
						// prevent image illegal if header is not pinned
						imageHeight = $0 < 0 ? 0.001 : $0
					}
				}
			}
		}
		.coordinateSpace(name: "area")
		.overlay(
			// >> any header
			Image("picture").resizable().scaledToFill()
			// << header end
				.frame(height: imageHeight)
				.clipped()
				.allowsHitTesting(false)
		, alignment: .top)
		.clipped()
    }
}

struct TestFlexibleStickyHeader_Previews: PreviewProvider {
    static var previews: some View {
        TestFlexibleStickyHeader()
    }
}
