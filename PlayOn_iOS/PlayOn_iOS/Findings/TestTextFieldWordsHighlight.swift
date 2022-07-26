// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestTextFieldWordsHighlight: View {
	@State private var text = "Hello!"
	var body: some View {
		// This would not work well with .bold or .italic, becuase changes gliphs
		// layout, so caret in TextField becomes non synchronized with text
		// Also there is no text scrolling in overlay, so no long texts
		// For real scanarios it is better to use UITextField representable!
		TextField("", text: $text).foregroundColor(.clear)
			.overlay(hilightedText(str: text, searched: "SwiftUI").allowsHitTesting(false), alignment: .leading)
	}
}

struct TestTextFieldWordsHighlight_Previews: PreviewProvider {
    static var previews: some View {
        TestTextFieldWordsHighlight()
    }
}
