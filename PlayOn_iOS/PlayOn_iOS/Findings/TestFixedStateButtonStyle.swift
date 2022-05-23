// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: 	By using this you agree do not repost any part of this code
//					on StackOverflow site. Thanks, Asperi.

import SwiftUI

struct TestFixedStateButtonStyle: View {
	var body: some View {
		Button("Demo") {}
			.buttonStyle(MyButtonStyle())
	}

	struct MyButtonStyle: ButtonStyle {
		@State private var flag = false
		func makeBody(configuration: Configuration) -> some View {
			configuration.label
				.padding()
				.foregroundColor(flag ? Color.white : Color.green)
				.background(flag ? Color.red : Color.clear)
				.onChange(of: configuration.isPressed) {
					if $0 {
						flag.toggle()
					}
				}
		}
	}

}

struct TestFixedStateButtonStyle_Previews: PreviewProvider {
	static var previews: some View {
		TestFixedStateButtonStyle()
	}
}
