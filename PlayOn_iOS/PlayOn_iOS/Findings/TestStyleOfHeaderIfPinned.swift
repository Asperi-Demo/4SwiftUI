// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestStyleOfHeaderIfPinned: View {
	var body: some View {
		ContentView()
	}
	
	struct ContentView: View {
		@State private var pinned: Int? = nil
		var body: some View {
			VStack {
				ScrollView {
					LazyVStack(alignment: .leading, spacing: 2, pinnedViews: .sectionHeaders) {
						ForEach(0..<5) { i in
							Section {
								ForEach(0..<20) { j in
									Text("Item \(j)")
										.frame(maxWidth: .infinity, minHeight: 32)
										.background(.blue)
								}
							} header: {
								HeaderView(value: "HEADER \(i + 1)", pinned: i == pinned)
									.background(GeometryReader {
										// detect current position of header
										Color.clear.preference(key: ViewOffsetKey.self,
											value: $0.frame(in: .named("area")).origin.y)
									})
							}
							.onPreferenceChange(ViewOffsetKey.self) {
								// verify if position is zero (pinned) in container coordinates
								if $0 == 0 {
									self.pinned = i
								} else if self.pinned == i {
									// clean-up if changed (might depend - for simplicity)
									self.pinned = nil
								}
							}
						}
					}
				}.clipped()
			}.coordinateSpace(name: "area")    // << here !!
		}
	}
	
	struct HeaderView: View {
		let value: String
		var pinned = true
		var body: some View {
			Text(value)
				.frame(maxWidth: .infinity, minHeight: 60)
				.padding(.horizontal)
				.background(.yellow).compositingGroup()
				// conditional shadow depding in pinned value
				.shadow(color: .red, radius: pinned ? 10 : 0, x: 0, y: pinned ? 10 : 0)
		}
	}
}

struct TestStyleOfHeaderIfPinned_Previews: PreviewProvider {
	static var previews: some View {
		TestStyleOfHeaderIfPinned()
	}
}
