// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard
//
// ATTENTION: 	By using this you agree do not repost any part of this code
//					on StackOverflow site. Thanks, Asperi.

import SwiftUI

public extension CGPoint {
	static func onCircle(hours: CGFloat, size: CGFloat) -> CGPoint {
		let radians = (3 - hours) * CGFloat.pi / CGFloat (6)
		let hypotenuse = size / 2
		return CGPoint(x: (size / 2 + 0.8 * hypotenuse * cos(radians)).rounded(.up),
							y: (size / 2 - 0.8 * hypotenuse * sin(radians)).rounded(.up))
	}
}
