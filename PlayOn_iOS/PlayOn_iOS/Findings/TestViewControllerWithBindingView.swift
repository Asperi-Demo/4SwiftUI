// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestViewControllerWithBindingView: View {

	var body: some View {
		DemoView()
	}

	struct RatingView: View {

		@Binding var rating: Int?

		private func starType(index: Int) -> String {

			if let rating = rating {
				return index <= rating ? "star.fill" : "star"
			} else {
				return "star"
			}
		}

		var body: some View {
			HStack {
				ForEach(1...5, id: \.self) { index in
					Image(systemName: self.starType(index: index))
						.foregroundColor(Color.orange)
						.onTapGesture {
							rating = index
						}
				}
			}
		}
	}

	class ViewController: UIViewController, ObservableObject {
		@Published var value: Int? = 1

		private struct Holder: View {
			@ObservedObject var vm: ViewController
			var body: some View {
				RatingView(rating: $vm.value)
			}
		}

		override func viewDidLoad() {
			super.viewDidLoad()

			// !! this will keep cross-reference so needs careful breaking on needed
			// moment e.g. when self.view is removed from super view, or something
			let hostingController = UIHostingController(rootView: Holder(vm: self))

			guard let testView = hostingController.view else { return }
			testView.translatesAutoresizingMaskIntoConstraints = false
			self.view.addSubview(testView)
			testView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
			testView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
			self.addChild(hostingController)
		}
	}

	struct DemoView: UIViewControllerRepresentable {
		func makeUIViewController(context: Context) -> some UIViewController {
			ViewController()
		}
		func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
		}
	}
}

struct TestViewControllerWithBindingView_Previews: PreviewProvider {
	static var previews: some View {
		TestViewControllerWithBindingView()
	}
}

