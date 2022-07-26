// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI
import QuickLook

struct TestControllerRepresentableDirectCall: View {
	@Environment(\.weakBox) var weakBox

	let testURL: URL = Bundle.main.url(forResource: "demo", withExtension: "png")!

	var body: some View {
		VStack {
			QuickLookController(url: testURL, onDismiss: {})
			Button("Reset") {
				weakBox.qlController?.reloadData()
			}
		}
	}
}

struct TestControllerRepresentableDirectCall_Previews: PreviewProvider {
	static var previews: some View {
		TestControllerRepresentableDirectCall()
	}
}

class WeakBox {
	weak var qlController: QLPreviewController?    // don't hold !!
	// ... add other controllers here

	struct WeakBoxKey: EnvironmentKey {
		static let defaultValue = WeakBox()
	}
}

extension EnvironmentValues {
	var weakBox: WeakBox {
		get { self[WeakBox.WeakBoxKey.self] }
	}
}

struct QuickLookController: UIViewControllerRepresentable {

	var url: URL
	var onDismiss: () -> Void

	func makeCoordinator() -> Coordinator {
		Coordinator(self)
	}

	func updateUIViewController(_ viewController: UINavigationController, context: UIViewControllerRepresentableContext<QuickLookController>) {
		if let controller = viewController.topViewController as? QLPreviewController {
			controller.reloadData()
		}
	}

	func makeUIViewController(context: Context) -> UINavigationController {
		let controller = QLPreviewController()
		context.environment.weakBox.qlController = controller        // << here !!

		controller.dataSource = context.coordinator
		controller.reloadData()
		return UINavigationController(rootViewController: controller)
	}


	class Coordinator: NSObject, QLPreviewControllerDataSource {
		var parent: QuickLookController

		init(_ qlPreviewController: QuickLookController) {
			self.parent = qlPreviewController
			super.init()
		}
		func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
			return 1
		}
		func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
			return self.parent.url as QLPreviewItem
		}

	}
}
