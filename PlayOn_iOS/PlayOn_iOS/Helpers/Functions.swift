// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: 	By using this you agree do not repost any part of this code
//					on StackOverflow site. Thanks, Asperi.

import SwiftUI

/// Constructs a Text of string with highlighted searched word using specified color (default is red)
public func hilightedText(str: String, searched: String, color: Color = .red) -> Text {
	guard !str.isEmpty && !searched.isEmpty else { return Text(str) }

	var result: Text!
	let parts = str.components(separatedBy: searched)
	for i in parts.indices {
		result = (result == nil ? Text(parts[i]) : result + Text(parts[i]))
		if i != parts.count - 1 {
			result = result + Text(searched).foregroundColor(color)
		}
	}
	return result ?? Text(str)
}
