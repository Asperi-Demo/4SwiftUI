// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: 	By using this you agree do not repost any part of this code
//					on StackOverflow site. Thanks, Asperi.

import UIKit

extension UIView {
	/// Find parent scroll view if there are any (replication of `NSView.enclosingScrollView`)
	func enclosingScrollView() -> UIScrollView? {
		var next: UIView? = self
		repeat {
			next = next?.superview
			if let scrollview = next as? UIScrollView {
				return scrollview
			}
		} while next != nil
		return nil
	}
}
