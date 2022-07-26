// 🔥BOYCOTT on russia - terrorist must be punished!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestLazyGridTransformation: View {
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 15) {
                ForEach(0..<20) { number in
					ItemView(value: number)
                }
            }.padding(.all, 40)
        }
    }

	struct ItemView: View {
		var value: Int

		let baseAngl = CGFloat.pi/30
		var body: some View {
			Button(action: {}) {  // << uncomment for demo
			Rectangle()
				.foregroundColor(Color.red)
				.frame(width: 50, height: 80)
				.cornerRadius(10)
				.shadow(color: .black, radius: 3, x: 1, y: 1)
				.overlay(
					Text("\(value)").foregroundColor(.white)
				)
				.rotationEffect(.radians(CGFloat(value % 5 - 2) * baseAngl), anchor: .bottom)
				.offset(y: UIScreen.main.bounds.height * (1 - cos(CGFloat(value % 5 - 2) * baseAngl)))
			}
		}
	}

}

struct TestLazyGridTransformation_Previews: PreviewProvider {
    static var previews: some View {
        TestLazyGridTransformation()
    }
}
