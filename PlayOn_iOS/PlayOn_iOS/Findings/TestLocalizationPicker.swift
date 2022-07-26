// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestLocalizationPicker: View {
	@AppStorage("language") var language: String = "en"
	var body: some View {
		VStack {
			Text("Selected: " + language)
			Picker("", selection: $language) {
				ForEach(Bundle.main.localizations, id: \.self) {
					Text((Locale.current as NSLocale).localizedString(forLanguageCode: $0)!).tag($0)
				}
			}
		}
	}
}

struct TestLocalizationPicker_Previews: PreviewProvider {
	static var previews: some View {
		TestLocalizationPicker()
	}
}
