// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

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

// MARK: -
extension UIView {
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
// [!!] Uncomment to clip resulting image
//             rendererContext.cgContext.addPath(
//                UIBezierPath(roundedRect: bounds, cornerRadius: 20).cgPath)
//            rendererContext.cgContext.clip()

// As commented by @MaxIsom below in some cases might be needed
// to make this asynchronously, so uncomment below DispatchQueue
// if you'd same met crash
//            DispatchQueue.main.async {
                 layer.render(in: rendererContext.cgContext)
//            }
        }
    }
}
