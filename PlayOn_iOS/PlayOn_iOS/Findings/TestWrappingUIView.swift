// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestWrappingUIView: View {
	var body: some View {
		MyView()
	}

	struct MyView: View {
		@State var isGreen = true

		var toggleColor = Action()

		var body: some View {
			VStack {
				Text("Hello, World!")
					.background(isGreen ? Color.green : Color.blue)
				Spacer().frame(height: 20)
				Anything(UIButton(type: .system)) {
					$0.setTitle("Try me!", for: .normal)

					$0.addTarget(toggleColor, action: #selector(Action.perform(sender:)), for: .touchUpInside)
					toggleColor.action = {
						isGreen.toggle()
					}
				}
				.frame(height: 30)
				.padding()
			}
		}

		class Action: NSObject {
			var action: (() -> Void)?
			@objc func perform(sender: Any?) {
				action?()
			}
		}
	}

	struct Anything<Wrapper: UIView>: UIViewRepresentable {
		typealias Updater = (Wrapper, Context) -> Void

		var makeView: () -> Wrapper
		var update: (Wrapper, Context) -> Void
		var action: (() -> Void)?

		init(_ makeView: @escaping @autoclosure () -> Wrapper,
			  updater update: @escaping (Wrapper) -> Void) {
			self.makeView = makeView
			self.update = { view, _ in update(view) }
		}

		func makeUIView(context: Context) -> Wrapper {
			makeView()
		}

		func updateUIView(_ view: Wrapper, context: Context) {
			update(view, context)
		}
	}

}

struct TestWrappingUIView_Previews: PreviewProvider {
	static var previews: some View {
		TestWrappingUIView()
	}
}
