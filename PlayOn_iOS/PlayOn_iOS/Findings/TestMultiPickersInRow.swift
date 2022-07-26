// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestMultiPickersInRow: View {
	var body: some View {
		ContentView()
	}

	struct ContentView: View {
		@State private var selection1 = 0
		@State private var selection2 = 0
		@State private var selection3 = 0

		var body: some View {
			HStack {
				NumberPickerView(selection: $selection1)
				NumberPickerView(selection: $selection2)
				NumberPickerView(selection: $selection3)
			}
		}
	}

	struct NumberPickerView: View {
		@Binding var selection : Int
		var body: some View {
			Picker("Number", selection: $selection) {
				ForEach(0..<100) { index in
					Text("\(index)")
				}
			}
			.pickerStyle(.wheel)
			.frame(width: 50)
			.clipped()
		}
	}

}

struct TestMultiPickersInRow_Previews: PreviewProvider {
	static var previews: some View {
		TestMultiPickersInRow()
	}
}

extension UIPickerView {
	override open func didMoveToSuperview() {
		super.didMoveToSuperview()
		self.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
	}
}

