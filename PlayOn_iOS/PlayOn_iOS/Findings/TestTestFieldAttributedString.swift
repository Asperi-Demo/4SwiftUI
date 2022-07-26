// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestTestFieldAttributedString: View {
	var body: some View {
		ContentView()
	}

	struct ContentView: View {

		@State var text = AttributedString(stringLiteral: "Test")

		var body: some View {
			VStack {

				CustomTextView(text: $text) { text in
					print(text)
				}
				.background(Color.gray.opacity(0.5))
				.frame(height: 50)
				.padding()

			}
		}
	}

	struct CustomTextView : UIViewRepresentable {

		@Binding var text : AttributedString
		var onCommit: (AttributedString) -> Void

		class Coordinator : NSObject, UITextFieldDelegate {
			var parent : CustomTextView
			var onCommit : (AttributedString) -> Void

			deinit {
				NotificationCenter.default.removeObserver(self)
			}

			init(_ parent : CustomTextView,onCommit : @escaping (AttributedString) -> Void ) {
				self.parent = parent
				self.onCommit = onCommit
			}

			@objc func textFiledDidChange(_ notification : Notification) {
				guard let textField = notification.object as? UITextField else { return }
				if let text = textField.attributedText {
					let newText = process(text)
					self.parent.$text.wrappedValue = AttributedString(newText)
				}
			}

			func textFieldDidEndEditing(_ textField : UITextField) {
				if let newText = textField.attributedText {
					self.onCommit(AttributedString(newText))
				}
			}

			func textFieldShouldReturn(_ textField: UITextField) -> Bool {
				return textField.endEditing(false)
			}

			// trivial demo parser
			func process(_ text: NSAttributedString) -> NSAttributedString {
				if let newText = text.mutableCopy() as? NSMutableAttributedString {
					let string = text.string as NSString
					let range = string.range(of: "18")
					if range.length != 0 {
						newText.replaceCharacters(in: range, with: NSAttributedString(string: "18", attributes: [.backgroundColor : UIColor.systemPink]))
						return newText
					}
				}
				return text
			}
			//        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

			// as alternate it can parsed here instead of `textFiledDidChange`

			//            return true
			//        }

		}


		func makeCoordinator() -> Coordinator {
			Coordinator(self, onCommit: onCommit)
		}

		func makeUIView(context: Context) -> UITextField {
			let textFiled = UITextField()

			textFiled.delegate = context.coordinator
			textFiled.autocorrectionType = .no
			textFiled.autocapitalizationType = .none
			NotificationCenter.default.addObserver(context.coordinator, selector: #selector(Coordinator.textFiledDidChange(_:)), name: UITextField.textDidChangeNotification, object: textFiled)
			return textFiled
		}

		func updateUIView(_ uiView: UITextField, context: Context) {
			uiView.attributedText = NSAttributedString(text)
		}

	}
}

struct TestTestFieldAttributedString_Previews: PreviewProvider {
	static var previews: some View {
		TestTestFieldAttributedString()
	}
}
