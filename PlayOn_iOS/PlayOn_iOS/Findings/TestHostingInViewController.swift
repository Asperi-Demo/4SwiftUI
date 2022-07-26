// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestHostingInViewController: View {
	@EnvironmentObject var sceneDelegate: SceneDelegate
	var body: some View {
		Buttons()
			.onAppear {
				sceneDelegate.window?.rootViewController = ViewController()
			}
	}

	struct Buttons: View {

		@State var isButton1Hidden = false
		@State var isButton2Hidden = true
		@State var isButton3Hidden = true

		var body: some View {
			VStack {
				if !isButton1Hidden {
					Button {
						isButton2Hidden.toggle()
					} label: {
						Image(systemName: "triangle")
							.foregroundColor(.white)
					}
					.frame(width: 50.0, height: 50.0)
					.background(.black.opacity(0.7))
					.clipShape(Circle())
				}

				if !isButton2Hidden {
					Button {
						// Action
						isButton3Hidden.toggle()
					} label: {
						Image(systemName: "circle")
							.foregroundColor(.white)
					}
					.frame(width: 50.0, height: 50.0)
					.background(.black.opacity(0.7))
					.clipShape(Circle())
					.onDisappear { isButton3Hidden = true }
				}

				if !isButton3Hidden {
					Button {
						// Action
					} label: {
						Image(systemName: "square")
							.foregroundColor(.white)
					}
					.frame(width: 50.0, height: 50.0)
					.background(.black.opacity(0.7))
					.clipShape(Circle())
				}
				Spacer()
			}
		}
	}

	class ViewController: UIViewController {
		override func viewDidLoad() {
			super.viewDidLoad()
			self.view.backgroundColor = .white
			let buttons = Buttons()
			let hostingController = UIHostingController(rootView: buttons)
			hostingController.view.translatesAutoresizingMaskIntoConstraints = false
			hostingController.view.backgroundColor = .clear
			addChild(hostingController)
			view.addSubview(hostingController.view)


			let horizConstraint = hostingController.view.trailingAnchor.constraint(
				equalTo: view.trailingAnchor,
				constant: -16.0
			)

			let vertConstraint = hostingController.view.topAnchor.constraint(
				equalTo: view.safeAreaLayoutGuide.topAnchor,
				constant: 16.0
			)
			let vertConstraint1 = hostingController.view.bottomAnchor.constraint(
				equalTo: view.safeAreaLayoutGuide.bottomAnchor,
				constant: 16.0
			)

			NSLayoutConstraint.activate([horizConstraint, vertConstraint, vertConstraint1])
			hostingController.view.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
			hostingController.view.setContentHuggingPriority(.defaultLow, for: .vertical)
		}
	}
}

struct TestHostingInViewController_Previews: PreviewProvider {
	static var previews: some View {
		TestHostingInViewController.Buttons()
	}
}
