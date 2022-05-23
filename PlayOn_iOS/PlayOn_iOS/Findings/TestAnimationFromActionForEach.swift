// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard
//
// ATTENTION: 	By using this you agree do not repost any part of this code
//					on StackOverflow site. Thanks, Asperi.

import SwiftUI

struct TestAnimationFromActionForEach: View {
	var body: some View {
		AnimationQuestion()
	}

	struct AnimationQuestion: View {
		@State var colors = "🟪🟨🟧🟦🟥🟫⬛️🟩⬜️".map { String($0) }
		@State var reversedColors = "⬜️🟩⬛️🟫🟥🟦🟧🟨🟪".map { String($0) }

		var body: some View {
			VStack {
				Spacer()
				Button("Tap") {
					let temp = colors
					for i in 0 ..< colors.count {
						withAnimation(.linear(duration: 4.0)) {
							colors[i] = reversedColors[i]
						}
					}
					reversedColors = temp

				}
				Spacer()

				HStack {
					ForEach(Array(colors.enumerated()), id: \.1) { index, color in
						Text(color).tag(index)
					}
				}
				Spacer()
			}
		}
	}

}

struct TestAnimationFromActionForEach_Previews: PreviewProvider {
	static var previews: some View {
		TestAnimationFromActionForEach()
	}
}
