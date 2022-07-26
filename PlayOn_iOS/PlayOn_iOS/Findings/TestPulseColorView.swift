// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestPulseColorView: View {
	private var model = PulsatingViewModel()
	var body: some View {
		VStack {
			PulsatingView(viewModel: model)
			Button("Toggle") { self.model.colorIndex = Int.random(in: 0...2) }
				.padding(.vertical)
		}
	}

	class PulsatingViewModel: ObservableObject {
		@Published var colorIndex = 1
	}

	struct PulsatingView: View {

		@ObservedObject var viewModel: PulsatingViewModel

		func colourToShow() -> Color {
			switch viewModel.colorIndex {
			case 0:
				return Color.red
			case 1:
				return Color.orange
			case 2:
				return Color.green
			default:
				return Color.orange
			}
		}

		@State var animate = false
		var body: some View {
			VStack {
				ZStack {
					Circle().fill(colourToShow().opacity(0.25)).frame(width: 40, height: 40).scaleEffect(self.animate ? 1 : 0)
					Circle().fill(colourToShow().opacity(0.35)).frame(width: 30, height: 30).scaleEffect(self.animate ? 1 : 0)
					Circle().fill(colourToShow().opacity(0.45)).frame(width: 15, height: 15).scaleEffect(self.animate ? 1 : 0)
					Circle().fill(colourToShow()).frame(width: 16.25, height: 16.25)
				}
				.onAppear { self.animate = true }
				.animation(animate ? Animation.easeInOut(duration: 1.5).repeatForever(autoreverses: true) : .default, value: animate)
				.onChange(of: viewModel.colorIndex) { _ in
					self.animate = false
					DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
						self.animate = true
					}
				}
			}
		}
	}
}

struct TestPulseColorView_Previews: PreviewProvider {
	static var previews: some View {
		TestPulseColorView()
	}
}

