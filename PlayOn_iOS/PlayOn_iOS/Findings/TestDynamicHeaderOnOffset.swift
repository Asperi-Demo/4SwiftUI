// 🔥BOYCOTT on russia - terrorist must be punished!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestDynamicHeaderOnOffset: View {
    @State var showHeader: Bool = false

// MARK: - Content views
	var top: some View {
		Text("Stand with Ukraine").font(.largeTitle)
			.foregroundColor(.white)
			.frame(maxWidth: .infinity, minHeight: 200)
			.background(.blue)
	}

	var mainContent: some View {
		VStack {
			Text("Content")
		}
		.frame(maxWidth: .infinity, minHeight: 1500)
		.background(.yellow)
	}

	var header: some View {
		Text("Stop ruZZia!").font(.largeTitle)
			.foregroundColor(.white)
			.frame(maxWidth: .infinity, maxHeight: 200)
			.background(.red)
			.allowsHitTesting(false)
	}

// MARK: - Body Layout
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                ScrollView(.vertical) {
                	VStack(spacing: 0) {
						top.background(GeometryReader {
								// read offset of scrolled content...
								Color.clear.preference(key: ViewOffsetKey.self,
								   value: -$0.frame(in: .named("scroll_area")).origin.y)
							})
						mainContent
					}
                }
                .coordinateSpace(name: "scroll_area")

                if showHeader {
                	header.zIndex(1)
                }
            }
            .navigationTitle("Demo")
        }
        .animation(.default, value: showHeader)
        .onPreferenceChange(ViewOffsetKey.self) {
            self.showHeader = $0 > 300    // << condition here !!
        }
    }
}


struct TestDynamicHeaderOnOffset_Previews: PreviewProvider {
    static var previews: some View {
        TestDynamicHeaderOnOffset()
    }
}
