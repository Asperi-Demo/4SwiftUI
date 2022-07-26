// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestTextEditorToFocus: View {
	var body: some View {
		ContentView()
	}
	
	struct ContentView: View {
		@State private var text: String = ""
		
		init() {
			UITextView.appearance().backgroundColor = .clear
		}
		
		@FocusState var inFocus: Int?
		var body: some View {
			ScrollViewReader { sp in
				ScrollView {
					TextEditor(text: $text).id(0)
						.focused($inFocus, equals: 0)
						.frame(height: 300)
						.background(.yellow)
					
					TextEditor(text: $text).id(1)
						.focused($inFocus, equals: 1)
						.frame(height: 300)
						.background(.mint)
					
					TextEditor(text: $text).id(2)
						.focused($inFocus, equals: 2)
						.frame(height: 300)
						.background(.teal)
					
					if inFocus == 2 {
						Color.clear.frame(height: 300)
					}
				}
				.onChange(of: inFocus) { id in
					withAnimation {
						sp.scrollTo(id)
					}
				}
			}
		}
	}
}

struct TestTextEditorToFocus_Previews: PreviewProvider {
	static var previews: some View {
		TestTextEditorToFocus()
	}
}
