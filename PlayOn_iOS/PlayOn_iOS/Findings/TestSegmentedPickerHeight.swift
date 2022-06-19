// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: 	By using this you agree do not repost any part of this code
//					on StackOverflow site. Thanks, Asperi.

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
