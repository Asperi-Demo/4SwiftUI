// 🔥BOYCOTT on russia - terrorist must be punished!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestTabViewExtraSelectionImage: View {
	@State private var selection = 0
	@Namespace var ns

	private let numberOfTabs = 2

	var body: some View {
		TabView(selection: $selection) {
			Color.yellow.overlay(Text("One"))
				.tabItem { Label("Car", systemImage: "car") }.tag(0)

			Color.blue.overlay(Text("Two"))
				.tabItem { Label("Home", systemImage: "house") }.tag(1)
		}
		.overlay(selector, alignment: .bottom)
		.edgesIgnoringSafeArea(.bottom)
	}

	private var selector: some View {
		HStack(spacing: 0) {
			ForEach(0..<numberOfTabs, id: \.self) { i in
				Color.clear.overlay(Group{
					if i == selection {
						Image(systemName: "arrowtriangle.up.fill")
							.resizable().aspectRatio(contentMode: .fit)
							.matchedGeometryEffect(id: "mark", in: ns)
							.foregroundColor(.blue)
					}
				}).frame(maxWidth: .infinity)
			}
		}
		.frame(maxHeight: 24)
		.animation(.default, value: selection)
	}
}

struct TestTabViewExtraSelectionImage_Previews: PreviewProvider {
    static var previews: some View {
        TestTabViewExtraSelectionImage()
    }
}

