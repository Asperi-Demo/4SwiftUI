// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: 	By using this you agree do not repost any part of this code
//					on StackOverflow site. Thanks, Asperi.

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
