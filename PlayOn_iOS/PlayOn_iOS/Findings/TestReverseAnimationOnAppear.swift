// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: 	By using this you agree do not repost any part of this code
//					on StackOverflow site. Thanks, Asperi.

import SwiftUI

struct TestReverseAnimationOnAppear: View {
	var body: some View {
		DemoReverseAnimation()
	}
	
	struct DemoReverseAnimation: View {
		@State var scalingFactor: CGFloat = 1
		
		var body: some View {
			Text("hello world")
				.modifier(ReversingScale(to: scalingFactor) {
					self.scalingFactor = 1
				})
				.animation(.default, value: scalingFactor)
				.onAppear {
					self.scalingFactor = 3
				}
		}
	}
}

struct TestReverseAnimationOnAppear_Previews: PreviewProvider {
	static var previews: some View {
		TestReverseAnimationOnAppear()
	}
}
