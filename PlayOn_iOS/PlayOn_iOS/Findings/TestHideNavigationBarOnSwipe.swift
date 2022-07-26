// 🔥BOYCOTT on russia - terrorist must be punished!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestHideNavigationBarOnSwipe: View {

    var body: some View {
        NavigationView {
            List(0..<100) { i in
                Text("Item \(i)")
            }
            .background(NavigationConfigurator { navigationConfigurator in
                navigationConfigurator.hidesBarsOnSwipe = true     // << here !!
            })
            .navigationBarTitle(Text("Demo"), displayMode: .inline)
        }
    }

	struct NavigationConfigurator: UIViewControllerRepresentable {
		var configure: (UINavigationController) -> Void = { _ in }

		func makeUIViewController(context: Context) -> UIViewController {
			let controller = UIViewController()
			DispatchQueue.main.async {
				if let navigationController = controller.navigationController {
					self.configure(navigationController)
					print("Successfully obtained navigation controller")
				} else {
					print("Failed to obtain navigation controller")
				}
			}
			return controller
		}

		func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
		}
	}
}


struct TestHideNavigationBarOnSwipe_Previews: PreviewProvider {
    static var previews: some View {
        TestHideNavigationBarOnSwipe()
    }
}
