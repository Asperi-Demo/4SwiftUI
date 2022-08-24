// 🔥BOYCOTT on russia - terrorist must be punished!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestBadgeCardAlignment: View {

	let edge = CGFloat(64)

	var badge: some View {
		Circle()
			.fill(.white)
			.frame(width: edge, height: edge)
			.overlay(
				Circle()
					.fill(Color(.init(red: 1, green: 0.78, blue: 0.17, alpha: 1)))
					.frame(width: 57, height: 57)
					.overlay(
						VStack {
							Text("Oct").font(.system(size: 10))
							Text("16").font(.system(size: 22))
						}
					)
			)
			.zIndex(1)   // << just to keep it here but on top
			.alignmentGuide(HorizontalAlignment.trailing) { $0[.trailing] - edge/4}
			.alignmentGuide(VerticalAlignment.top) { $0[.top] + edge/4}
	}

	var body: some View {

		ZStack(alignment: .topTrailing) {
			badge

			VStack(alignment: .leading) {
				HStack {
					Text("Robbie Williams St. Patricks Party feat. The Demons (Rock)")
						.font(.system(size: 12))
						.foregroundColor(.white)
						.padding(10)
						.padding(.trailing, edge/2)
				}
				Group {
					Text("Wed 19:00 - 23:00")
						.font(.system(size: 10.5))
						.padding(.init(top: 0, leading: 10, bottom: 0, trailing: 0))
					Text("MTC Cologne, Cologne, Germany")
						.font(.system(size: 10.5))
						.padding(.init(top: 0, leading: 10, bottom: 0, trailing: 0))
				}.foregroundColor(.white)

				Spacer()
				HStack {
					Button() {

					} label: {
						Image("info").resizable()
							.frame(width: 21, height: 21)
							.colorInvert()
							.padding(14)
					}
					Spacer()

				}
			}.frame(width: 280, height: 160)
				.background(Color(.init(red: 0, green: 0, blue: 0, alpha: 1)).opacity(0.6))
		}

	}
}
struct TestBadgeCardAlignment_Previews: PreviewProvider {
    static var previews: some View {
        TestBadgeCardAlignment()
    }
}
