// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: 	By using this you agree do not repost any part of this code
//					on StackOverflow site. Thanks, Asperi.

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
