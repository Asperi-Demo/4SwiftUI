// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: 	By using this you agree do not repost any part of this code
//					on StackOverflow site. Thanks, Asperi.

import SwiftUI

struct TestCustomProcessingProgress: View {
	var body: some View {
		ContentView()
	}
	
	struct ContentView: View {
		@State var isLoading = false

		var body: some View {
			Button(action: {
				self.isLoading = true
			}) {
				HStack {
					if isLoading {
						MyProgress()
					}
					Text( isLoading ? "Processing" : "Submit")
						.fontWeight(.semibold)
						.font(.title)
				}
			}
			.frame(width: 250, height: 50)
			.background(.white)
		}

		struct MyProgress: View {
			@State var isLoading = false
			var body: some View {
				Circle()
					.trim(from: 0, to: 0.7)
					.stroke(Color.green, lineWidth: 5)
					.frame(width: 50, height: 50)
					.rotationEffect(Angle(degrees: isLoading ? 360 : 0))
					.animation(.linear
						.repeatForever(autoreverses: false), value: isLoading)
					.onAppear {
						isLoading = true
					}
			}
		}
	}
}

struct TestCustomProcessingProgress_Previews: PreviewProvider {
	static var previews: some View {
		TestCustomProcessingProgress()
	}
}
