// 🔥BOYCOTT on russia - terrorist must be punished!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestColorPickerOnButton: View {

    @State private var color: Color = Color.green

    var body: some View {
    	Button {
			UIColorWellHelper.helper.execute?()
		} label: {
			Text("Show Color Picker")
		}
		.buttonStyle(.borderedProminent)
		.background(
			ColorPicker("", selection: $color, supportsOpacity: false)
				.labelsHidden().opacity(0)
		)
    }
}

extension UIColorWell {

	override open func didMoveToSuperview() {
		super.didMoveToSuperview()

		if let uiButton = self.subviews.first?.subviews.last as? UIButton {
			UIColorWellHelper.helper.execute = {
				uiButton.sendActions(for: .touchUpInside)
			}
		}
	}
}

class UIColorWellHelper: NSObject {
	static let helper = UIColorWellHelper()
	var execute: (() -> ())?
	@objc func handler(_ sender: Any) {
		execute?()
	}
}

struct TestColorPickerOnButton_Previews: PreviewProvider {
    static var previews: some View {
        TestColorPickerOnButton()
    }
}
