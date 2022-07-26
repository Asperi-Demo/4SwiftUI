// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestSegmentedPickerHeight: View {
    @State private var selectedElement = ""

    var body: some View {
		Picker(selection: .constant(1), label: Text("Picker")) {
			Text("Hello").tag(1)
			Text("World").tag(2)
		}
		.frame(height: 60) // << uncomment below extension to test !!
		.pickerStyle(SegmentedPickerStyle())
    }
}

//extension UISegmentedControl {
//	override open func didMoveToSuperview() {
//		super.didMoveToSuperview()
//		self.setContentHuggingPriority(.defaultLow, for: .vertical)
//	}
//}

struct TestSegmentedPickerHeight_Previews: PreviewProvider {
    static var previews: some View {
        TestSegmentedPickerHeight()
    }
}
