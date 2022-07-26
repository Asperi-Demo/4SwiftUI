// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestCustomModal: View {
	var body: some View {
		ElementsList()
	}

	struct ElementsList: View {
		@State var elements: [String] = (0..<100).map { "Element #\($0)" }
		@State private var isModal = false
		var body: some View {
			ModalView(isPresented: $isModal) { // made as container, but ...
				List(elements, id: \.self) {
					Text($0)
						.onTapGesture {
							// what to do here to display ModalView as I want to?
							isModal = true
						}
				}
				.listStyle(PlainListStyle())
			}
		}
	}

	struct ModalView<V: View>: View {    // ... can be also as view modifier
		@Binding var isPresented: Bool
		@ViewBuilder var content: () -> V

		var body: some View {
			ZStack {
				content()  // << wrapped content is here !!

				ZStack { // transarent container for modal
					VStack {   // << to demo different animations for background ...
						if isPresented {
							Color.black.opacity(0.8)
								.transition(.opacity)
						}
					}.animation(.easeInOut(duration: 0.25), value: isPresented)

					VStack {  // ... and drawer
						if isPresented {
							Color.white
								.cornerRadius(20.0)
								.padding(.top, 150)
								.offset(x: 0, y: 10)  // just to compensate spring (optional)
								.transition(.move(edge: .bottom))
						}
					}.animation(.spring().delay(0.3), value: isPresented)
				}
				.frame(maxWidth: .infinity, maxHeight: .infinity)
				.ignoresSafeArea()
				.onTapGesture {
					isPresented = false
				}
			}
		}
	}

}

struct TestCustomModal_Previews: PreviewProvider {
	static var previews: some View {
		TestCustomModal()
	}
}
