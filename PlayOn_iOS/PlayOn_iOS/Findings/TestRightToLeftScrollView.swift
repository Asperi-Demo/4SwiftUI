// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: 	By using this you agree do not repost any part of this code
//					on StackOverflow site. Thanks, Asperi.

import SwiftUI

struct TestRightToLeftScrollView: View {
	var body: some View {
		VStack(spacing: 1){
			ScrollView(.horizontal, showsIndicators: false) {
				HStack(spacing: 20) {
					ForEach(0..<5) { item in
						VStack(alignment: .trailing) {
							Image("picture")
								.resizable()
								.scaledToFit()
								.cornerRadius(20)
								.shadow(color: .black.opacity(0.1), radius: 20, x: 20, y: 20)
								.frame(maxWidth: 150, maxHeight: 200)

							Text("start here")
							Text("new").foregroundColor(Color.red)
						}
					}
				}.padding()
				.scaleEffect(CGSize(width: -1, height: 1))
			}
			.scaleEffect(CGSize(width: -1, height: 1))
		}
	}
}

struct TestRightToLeftScrollView_Previews: PreviewProvider {
    static var previews: some View {
        TestRightToLeftScrollView()
    }
}
