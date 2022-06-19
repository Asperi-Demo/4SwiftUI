// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: 	By using this you agree do not repost any part of this code
//					on StackOverflow site. Thanks, Asperi.

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
