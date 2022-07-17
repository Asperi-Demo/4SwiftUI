// 🔥BOYCOTT on russia - terrorist must be punished!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION:     By using this you agree do not repost any part of this code
//                    on StackOverflow site. Thanks, Asperi.

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
                    Color.clear.preference(key: ViewHeightKey.self,
                        value: $0.frame(in: .local).size.width)
                })
                .onPreferenceChange(ViewHeightKey.self) {
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
