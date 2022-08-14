// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

// Use this view in background of WindowScene root view to block animated orientation changes
struct OrientationAnimationBlockerView: UIViewControllerRepresentable {
	func makeUIViewController(context: Context) -> some UIViewController {
		OrientationHandler()
	}

	func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
	}

	class OrientationHandler: UIViewController {
		override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
			coordinator.animate(alongsideTransition: nil) { _ in
				UIView.setAnimationsEnabled(true)
			}
			UIView.setAnimationsEnabled(false)
			super.viewWillTransition(to: size, with: coordinator);
		}
	}
}

struct ScrollViewConfigurator: UIViewRepresentable {
	let configure: (UIScrollView?) -> ()
	func makeUIView(context: Context) -> UIView {
		let view = UIView()
		DispatchQueue.main.async {
			configure(view.enclosingScrollView())
		}
		return view
	}

	func updateUIView(_ uiView: UIView, context: Context) {}
}
