// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard
//
// ATTENTION: 	By using this you agree do not repost any part of this code
//					on StackOverflow site. Thanks, Asperi.

import SwiftUI

struct TestRoundedSelectionList: View {
	var body: some View {
		ContentView()
	}
	
	struct ContentView: View {
		var body: some View {
			List {
				ForEach(0..<4) { i in
					Text("Item \(i)").font(.system(size: 32))
						.listRowBackground(Group {
							if 1 == i {
								Color.yellow.mask(RoundedRectangle(cornerRadius: 30))
							} else { Color.clear }
						})
				}
			}
			.preferredColorScheme(.dark)
		}
	}
}

struct TestRoundedSelectionList_Previews: PreviewProvider {
	static var previews: some View {
		TestRoundedSelectionList()
	}
}
