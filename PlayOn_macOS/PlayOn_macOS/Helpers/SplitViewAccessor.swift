// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI
import AppKit

struct SplitViewAccessor: NSViewRepresentable {
	@Binding var sideCollapsed: Bool

	func makeNSView(context: Context) -> some NSView {
		let view = MyView()
		view.sideCollapsed = _sideCollapsed
		return view
	}

	func updateNSView(_ nsView: NSViewType, context: Context) {
	}

	class MyView: NSView {
		var sideCollapsed: Binding<Bool>?

		weak private var controller: NSSplitViewController?
		private var observer: Any?

		override func viewDidMoveToWindow() {
			super.viewDidMoveToWindow()
			var sview = self.superview
			while sview != nil, !sview!.isKind(of: NSSplitView.self) {
				sview = sview?.superview
			}
			guard let sview = sview as? NSSplitView else { return }
			controller = sview.delegate as? NSSplitViewController
			if let sideBar = controller?.splitViewItems.first {
				observer = sideBar.observe(\.isCollapsed, options: [.new]) { [weak self] _, change in
					if let value = change.newValue {
						self?.sideCollapsed?.wrappedValue = value
					}
				}
			}
		}
	}
}

