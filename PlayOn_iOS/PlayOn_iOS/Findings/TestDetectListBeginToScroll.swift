// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard
//
// ATTENTION: 	By using this you agree do not repost any part of this code
//					on StackOverflow site. Thanks, Asperi.

import SwiftUI

struct TestDetectListBeginToScroll: View {
	@State private var text = ""
	@FocusState var active: Bool
	var body: some View {
		VStack {
			TextField("Search", text: $text)
				.focused($active)
			List(0..<100) {
			  Text("Item \($0)")
			}
			.simultaneousGesture(DragGesture().onChanged({ _ in
				 // if keyboard is opened then hide it
				print(">> Got it!")
				active = false
			}))
		}
	}
}

struct TestDetectListBeginToScroll_Previews: PreviewProvider {
	static var previews: some View {
		TestDetectListBeginToScroll()
	}
}
