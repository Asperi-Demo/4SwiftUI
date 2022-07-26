// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestInputViewGenerics: View {
	var body: some View {
		TestView()
	}

	struct TestView: View {
		let testObject = TestObject()

		var body: some View {
			VStack {
				Spacer()
				TestInputView(object: testObject, keyPath: \.string)
				TestInputView(object: testObject, keyPath: \.integer)
				Spacer()
			}
			.ignoresSafeArea(.keyboard, edges: .bottom)
		}
	}

	class TestObject: ObservableObject {
		var integer: Int = 1
		var string: String = "Test"
	}

	struct TestInputView<ValueType: Inputable>: View {
		@ObservedObject var object: TestObject
		var keyPath: ReferenceWritableKeyPath<TestObject, ValueType>

		var binding: Binding<ValueType> {
			.init(
				get: { object[keyPath: keyPath] },
				set: { object[keyPath: keyPath] = $0 }
			)
		}

		var body: some View {
			ValueType.inputField(binding)
		}

	}
}

struct TestInputViewGenerics_Previews: PreviewProvider {
	static var previews: some View {
		TestInputViewGenerics()
	}
}

protocol Inputable {
	associatedtype V: View
	@ViewBuilder static func inputField(_ binding: Binding<Self>) -> Self.V
}

extension String: Inputable {
	static func inputField(_ binding: Binding<Self>) -> some View {
		TextField("Enter text...", text: binding)
	}
}

extension Int: Inputable {
	static func inputField(_ binding: Binding<Self>) -> some View {
		TextField("Enter number...", value: binding, format: .number)
			.keyboardType(.numberPad)
			.foregroundColor(.primary)
	}
}
