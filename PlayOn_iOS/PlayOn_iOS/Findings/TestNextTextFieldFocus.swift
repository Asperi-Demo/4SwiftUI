// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestNextTextFieldFocus: View {
	var body: some View {
		ContentView()
	}

	struct ContentView: View {
		@State var inputsValues: [String]
		@FocusState var focusedInput: Int?

		init() {
			inputsValues = (0..<30).map { _ in "" }
		}

		var body: some View {
			ScrollViewReader { proxy in
				ScrollView {
					VStack {
						ForEach((0..<inputsValues.count), id: \.self) { i in
							TextField("Value", text: $inputsValues[i])
								.focused($focusedInput, equals: i)
								.submitLabel(.next)
								.id(i)
								.onSubmit {
									// update state here !!
									if (i + 1) < inputsValues.count {
										focusedInput = i + 1
									} else {
										focusedInput = nil
									}
								}
						}
					}
					.onChange(of: focusedInput) {
						// react on state change here !!
						proxy.scrollTo($0)
					}
				}
			}
			.toolbar {
				ToolbarItem(placement: .keyboard) {
					Text("This is toolbar")
				}
			}
		}
	}
}

struct TestNextTextFieldFocus_Previews: PreviewProvider {
	static var previews: some View {
		TestNextTextFieldFocus()
	}
}
