// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TabViewDynamicHeight: View {
	@State private var selection: Int = 0
	@State private var rect: CGRect = .zero
	var body: some View {
		VStack {
			TabView(selection: $selection) {
				ForEach(0..<5, id: \.self) { index in
					VStack {
						Text("Text \(index)")
						Text("Text \(index)")
						Text("Text \(index)")
					}
					.frame(maxWidth: .infinity)
					.background(GeometryReader {
						Color.clear.preference(key: ViewRectKey.self,
													  value: [$0.frame(in: .local)])
					})
					.tag(index)
				}
			}
			.tabViewStyle(PageTabViewStyle())
			.frame(height: rect.size.height
					 + 60 /* just to avoid page indicator overlap */)
			.background(Color.red)
			.onPreferenceChange(ViewRectKey.self) { rects in
				self.rect = rects.first ?? .zero
			}
		}
	}
}

struct TabViewDynamicHeight_Previews: PreviewProvider {
    static var previews: some View {
        TabViewDynamicHeight()
    }
}
