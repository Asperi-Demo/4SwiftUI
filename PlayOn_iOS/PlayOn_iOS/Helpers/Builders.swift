// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

/// A list builder with type name as a header for a provided enum type
public func view<T: CaseIterable & Hashable>(for type: T.Type) -> some View where T.AllCases: RandomAccessCollection {
	VStack(alignment: .leading) {
		Text(String(describing: type)).bold()
		ForEach(type.allCases, id: \.self) { item in
			Text(String(describing: item))
		}
	}
}
