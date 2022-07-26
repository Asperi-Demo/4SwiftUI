// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

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

public func isInWidget() -> Bool {
    guard let extesion = Bundle.main.infoDictionary?["NSExtension"]
    	as? [String: String] else { return false }
    guard let widget = extesion["NSExtensionPointIdentifier"]
    	else { return false }
    return widget == "com.apple.widgetkit-extension"
}
