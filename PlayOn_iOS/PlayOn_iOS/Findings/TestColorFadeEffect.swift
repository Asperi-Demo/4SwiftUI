// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: 	By using this you agree do not repost any part of this code
//					on StackOverflow site. Thanks, Asperi.

import SwiftUI

struct TestColorFadeEffect: View {
	var body: some View {
		ContentView()
	}
	struct ContentView: View {

		@Namespace var namespaceOfCircle
		@State private var update: Bool = false

		var body: some View {
			VStack {
				if update {
					VStack {
						Circle()
							.matchedGeometryEffect(id: "Circle", in: namespaceOfCircle)
							.frame(width: 100, height: 100)
						Spacer()
					}
					.transition(.scale(scale: 1))      // << here !!
				}
				else {
					VStack {
						Spacer()
						Circle()
							.matchedGeometryEffect(id: "Circle", in: namespaceOfCircle)
							.frame(width: 300, height: 300)

					}
					.transition(.scale(scale: 1))       // << here !!
				}
			}
			.background(Button("update") { update.toggle() })
			.animation(.linear(duration: 5.0), value: update)
		}
	}
}

struct TestColorFadeEffect_Previews: PreviewProvider {
	static var previews: some View {
		TestColorFadeEffect()
	}
}
