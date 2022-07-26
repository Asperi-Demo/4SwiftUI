// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

extension Text {
	public init<S>(looking text: S, fallback table: String? = nil) where S : StringProtocol {
		let text = String(text)
		var translated = NSLocalizedString(text, comment: "")
		if translated == text, let table = table {
			translated = NSLocalizedString(text, tableName: table,
				bundle: .main, value: text, comment: "")
		}
		// already translated, so avoid search again
		self.init(verbatim: translated)
	}
}
