// 🔥BOYCOTT on russia - terrorist must be punished!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestCompressWheelPicker: View {
	@State private var selection = "Appricot"

    @State private var maxWidth = CGFloat.zero
	@State private var width = CGFloat.infinity

    var body: some View {
        Picker("", selection: $selection) {
            ForEach(["Appricot", "Carrot", "Potato"], id: \.self) {
				Text($0)
                .background(GeometryReader {
                    Color.clear.preference(key: ViewSideLengthKey.self,
                        value: $0.frame(in: .local).size.width)
                })
                .onPreferenceChange(ViewSideLengthKey.self) {
                    self.maxWidth = max($0, maxWidth)
                	width = self.maxWidth
                }
            }
        }
        .pickerStyle(.wheel)
		.frame(maxWidth: width + 2 * 20 /* padding on both sides */)
    }
}


struct TestCompressWheelPicker_Previews: PreviewProvider {
    static var previews: some View {
        TestCompressWheelPicker()
    }
}
