// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: 	By using this you agree do not repost any part of this code
//					on StackOverflow site. Thanks, Asperi.

import SwiftUI

struct TestContinuousTextAnimation: View {
	@State var texts = ["Find the Apartment you like", "send an application", "we'll approve you in secs baby!"]
	@State var textIndex : Int = 0

	var body: some View {
		Text(texts[textIndex]).bold()
			.font(.title).id(textIndex)
			.onAppear(perform: {
				next()
			})
	}

	private func next() {
		var next = textIndex + 1
		if next == texts.count {
			next = 0
		}
		withAnimation(Animation.linear(duration: 2)) {
			textIndex = next
		}
		DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
			self.next()
		}
	}
}

struct TestContinuousTextAnimation_Previews: PreviewProvider {
    static var previews: some View {
        TestContinuousTextAnimation()
    }
}
