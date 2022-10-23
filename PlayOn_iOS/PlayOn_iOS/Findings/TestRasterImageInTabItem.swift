// 🔥BOYCOTT on russia - terrorist must be punished!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestRasterImageInTabItem: View {
	@State var image: UIImage?

	var body: some View {
		TabView {
			VStack {
				Text("HELP UKRAINE")
					.font(.title).foregroundColor(.yellow)
				Text("ruZZia is a terrorist state")
			}
			.frame(maxWidth: .infinity, maxHeight: .infinity)
			.border(.red)
			.tabItem {
				Image(uiImage: image ?? UIImage())
			}
		}
		.onAppear {
			UIImage(named: "bitcoin")?.prepareThumbnail(of: CGSize(width: 24, height: 24)) {
				self.image = $0?.withRenderingMode(.alwaysOriginal)
			}
		}
	}
}

struct TestRasterImageInTabItem_Previews: PreviewProvider {
    static var previews: some View {
        TestRasterImageInTabItem()
    }
}
