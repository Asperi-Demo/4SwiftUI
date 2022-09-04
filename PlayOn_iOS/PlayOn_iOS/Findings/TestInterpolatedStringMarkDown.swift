// 🔥BOYCOTT on russia - terrorist must be punished!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestInterpolatedStringMarkDown: View {

	@State private var hostName: String = "developer.apple.com"

	var body: some View {
		let string = "[Use for help](https://\(hostName))"

		// used >> init<S>(_ content: S) where S : StringProtocol
		Text(string) 						// ❌ MarkDown does not work !!
		Text(LocalizedStringKey(string))    // << fix

		// used >> init(_ key: LocalizedStringKey,
		//          tableName: String? = nil,
		//			   bundle: Bundle? = nil,
		//			  comment: StaticString? = nil)
		Text("[Use for help](https://developer.apple.com)")
	}
}

struct TestInterpolatedStringMarkDown_Previews: PreviewProvider {
    static var previews: some View {
        TestInterpolatedStringMarkDown()
    }
}
