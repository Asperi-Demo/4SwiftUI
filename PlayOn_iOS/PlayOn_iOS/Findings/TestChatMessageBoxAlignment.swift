// 🔥BOYCOTT on russia - terrorist must be punished!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestChatMessageBoxAlignment: View {

	var body: some View {
		GeometryReader { gp in
			ScrollView {
				BubbleView(name: Lorem.long, time: "00:00", text: "OK", isLeft: false)
					.frame(maxWidth: gp.size.width * 0.85, alignment: .trailing)
					.frame(maxWidth: .infinity, alignment: .trailing)
				BubbleView(name: "Short", time: "00:00", text: Lorem.short, isLeft: false)
					.frame(maxWidth: gp.size.width * 0.85, alignment: .trailing)
					.frame(maxWidth: .infinity, alignment: .trailing)
				BubbleView(name: Lorem.short, time: "00:00", text: Lorem.long, color: .pink)
					.frame(maxWidth: gp.size.width * 0.85, alignment: .leading)
					.frame(maxWidth: .infinity, alignment: .leading)
			}
			.padding(.horizontal, 20)
		}
	}

	struct BubbleView: View {
		let name: String
		let time: String
		let text: String
		var color: Color = Color.gray
		var isLeft = true

		private func header(_ content: Text) -> some View {
			HStack {
				content
			}
			.font(.body.bold())
			.lineLimit(1)
		}

		var body: some View {
			VStack(alignment: isLeft ? .leading : .trailing) {
				if isLeft {
					header(Text(time) + Text(name + "\t").foregroundColor(Color.clear))
				} else {
					header(Text(time + "\t").foregroundColor(Color.clear) + Text(name))
				}
				Text(text)
					.multilineTextAlignment(.leading)
			}
			.overlay(Group {
				if isLeft {
					header(Text(time + "\t").foregroundColor(Color.clear) + Text(name))
				} else {
					header(Text(time) + Text(name + "\t").foregroundColor(Color.clear))
				}
			}, alignment: isLeft ? .topTrailing : .topLeading)
			.padding(8)
			.background(RoundedRectangle(cornerRadius: 12).fill(color.opacity(0.4)))
		}
	}
}

struct TestChatMessageBoxAlignment_Previews: PreviewProvider {
    static var previews: some View {
        TestChatMessageBoxAlignment()
    }
}
