// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

public extension Button {

	/// A helper constructor for a Button with simplified interface
	///
	/// Example:
	/// ```
	/// Button("Button", systemImage: "person") {
	///   print("pressed")
	/// }
	/// ```
	/// - Parameters:
	///   - title: A title of button (localizable)
	///   - systemImage: A name of SF symbol
	///   - action: A button action
	init(_ title: LocalizedStringKey, systemImage: String, action: @escaping () -> Void) where Label == SwiftUI.Label<Text, Image> {
		self.init(action: action, label: {
			SwiftUI.Label(title, systemImage: systemImage)
		})
	}
}
