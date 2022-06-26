// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: 	By using this you agree do not repost any part of this code
//					on StackOverflow site. Thanks, Asperi.

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
