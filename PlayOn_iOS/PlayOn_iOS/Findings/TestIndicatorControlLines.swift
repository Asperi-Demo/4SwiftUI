// 🔥BOYCOTT on russia - terrorist must be punished!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestIndicatorControlLines: View {
	@State private var value = CGFloat.zero
    var body: some View {
		IndicatorView(current: value)
			.contentShape(Rectangle())
			.onTapGesture {
				withAnimation {
				value = CGFloat((0...1000).randomElement()!)
				}
			}
			.padding(.horizontal)
    }
}

struct IndicatorView: View {
	var goal: CGFloat = 1000
	var current: CGFloat = 0
	var thick: CGFloat = 40

	private let arrow = Image(systemName: "triangle.fill").resizable()

	var body: some View {
		ZStack {
			Circle()
				.trim(from: 0.5, to: 1)
				.stroke(lineWidth: thick).foregroundColor(.yellow)
			Circle()
				.trim(from: 0.5, to: (current / goal) * 0.5 + 0.5)
				.stroke(lineWidth: thick).foregroundColor(.blue)
		}
		.padding(20)
		.aspectRatio(contentMode: .fit)
		.overlay(GeometryReader { gp in
			Color.clear.overlay(
			arrow.frame(width: 28, height: 28)
				.foregroundColor(.white)
				.overlay(arrow.padding(6).foregroundColor(current == .zero ? .yellow : .blue))
				.transformEffect(CGAffineTransform(translationX: 0, y: -gp.size.height / 2.0 + thick))
				.rotationEffect(.radians(-CGFloat.pi / 2.0 + (current / goal) * CGFloat.pi))
			)
		})
		.overlay(
			Text("\(current, specifier: "%.f")").font(.largeTitle).bold()
				.animation(.none, value: current)
		)
	}
}



struct TestIndicatorControlLines_Previews: PreviewProvider {
    static var previews: some View {
        TestIndicatorControlLines()
    }
}
