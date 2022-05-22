// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard
//
// ATTENTION: 	By using this you agree do not repost any part of this code
//					on StackOverflow site. Thanks, Asperi.

import SwiftUI
import QuickLook

struct TestControllerRepresentableDirectCall: View {
	@Environment(\.controllerBox) var controllerBox

	let testURL: URL = Bundle.main.url(forResource: "demo", withExtension: "png")!

	var body: some View {
		VStack {
			QuickLookController(url: testURL, onDismiss: {})
			Button("Reset") {
				controllerBox.qlController?.reloadData()
			}
		}
	}
}

struct TestControllerRepresentableDirectCall_Previews: PreviewProvider {
	static var previews: some View {
		TestControllerRepresentableDirectCall()
	}
}

class ControllersBox {
	weak var qlController: QLPreviewController?    // don't hold !!
	// ... add other controllers here

	struct ControllerBoxKey: EnvironmentKey {
		static let defaultValue = ControllersBox()
	}
}

extension EnvironmentValues {
	var controllerBox: ControllersBox {
		get { self[ControllersBox.ControllerBoxKey.self] }
		set { }
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
		context.environment.controllerBox.qlController = controller        // << here !!

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
