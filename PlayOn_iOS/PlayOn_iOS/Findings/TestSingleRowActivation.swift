// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

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
