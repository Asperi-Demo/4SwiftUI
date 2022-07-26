// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

public extension CGPoint {
	static func onCircle(hours: CGFloat, size: CGFloat) -> CGPoint {
		let radians = (3 - hours) * CGFloat.pi / CGFloat (6)
		let hypotenuse = size / 2
		return CGPoint(x: (size / 2 + 0.8 * hypotenuse * cos(radians)).rounded(.up),
							y: (size / 2 - 0.8 * hypotenuse * sin(radians)).rounded(.up))
	}
}

public extension CGRect {
	var center: CGPoint {
		CGPoint(x: midX, y: midY)
	}
}
