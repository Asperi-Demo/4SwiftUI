// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: 	By using this you agree do not repost any part of this code
//					on StackOverflow site. Thanks, Asperi.

import SwiftUI

struct TestSingleRowActivation: View {
	@State private var active: Int? = nil
    var body: some View {
        List {
			ForEach(0..<10) {
				Row(active: $active, index: $0)
			}
		}
    }

    struct Row: View {
    	@Binding var active: Int?
    	let index: Int
		var body: some View {
			HStack {
				Text("Item \(index)")
					.onTapGesture { active = index }
				Spacer()
				if index == active {
					Button("Done") { active = nil }
				}
			}
			.animation(.default, value: active)
		}
	}
}

struct TestSingleRowActivation_Previews: PreviewProvider {
    static var previews: some View {
        TestSingleRowActivation()
    }
}
