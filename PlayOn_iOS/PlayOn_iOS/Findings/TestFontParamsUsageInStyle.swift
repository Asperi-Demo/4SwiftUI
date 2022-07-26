// 🔥BOYCOTT on russia - terrorist must be punished!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestFontParamsUsageInStyle: View {

	private let uiFont = UIFont.preferredFont(forTextStyle: .title1)  // << model
	private var font: Font { Font(uiFont as CTFont) }    // UI

	var body: some View {
		NavigationView {
			HStack {
				Button(action: {}) {
					Image(systemName: "star")
				}

				Button(action: {}) {
					Image(systemName: "bolt.horizontal")
				}
			}
			.buttonStyle(CustomButtonStyle(font: uiFont))
			.font(font)

			.toolbar {
				ToolbarItem(placement: .principal) {
					HStack {
						VStack(alignment: .leading) {
							Text("Cosmic Serenity asdlkf ;asdfj kas;dlkf a;sdlfk asdkj")
							Text("Unreality")
						}
						Spacer()
					}
				}
				ToolbarItem(placement: .navigationBarTrailing) {
					HStack {
					Button(action: {}) {
						Image(systemName: "bell")
					}
					Button(action: {}) {
						Image(systemName: "lineweight")
					}
					}
				}
			}

		}
	}

	struct CustomButtonStyle: ButtonStyle {
		var font = UIFont.preferredFont(forTextStyle: .body)

		func makeBody(configuration: Configuration) -> some View {
			let size = font.lineHeight * 2.0
			configuration.label
				.frame(width: size, height: size)
				.background(.red)
		}

	}
}


struct TestFontParamsUsageInStyle_Previews: PreviewProvider {
    static var previews: some View {
        TestFontParamsUsageInStyle()
    }
}
