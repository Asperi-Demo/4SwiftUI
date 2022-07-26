// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI
import Combine

struct TestScrollDidEndDetect: View {
	var body: some View {
		ContentView()
	}

	struct ContentView: View {
		let detector: CurrentValueSubject<CGFloat, Never>
		let publisher: AnyPublisher<CGFloat, Never>

		init() {
			let detector = CurrentValueSubject<CGFloat, Never>(0)
			self.publisher = detector
				.debounce(for: .seconds(0.2), scheduler: DispatchQueue.main)
				.dropFirst()
				.eraseToAnyPublisher()
			self.detector = detector
		}

		var body: some View {
			ScrollView {
				VStack(spacing: 20) {
					ForEach(0...100, id: \.self) { i in
						Rectangle()
							.frame(width: 200, height: 100)
							.foregroundColor(.green)
							.overlay(Text("\(i)"))
					}
				}
				.frame(maxWidth: .infinity)
				.background(GeometryReader {
					Color.clear.preference(key: ViewOffsetKey.self,
												  value: -$0.frame(in: .named("scroll")).origin.y)
				})
				.onPreferenceChange(ViewOffsetKey.self) { detector.send($0) }
			}
			.coordinateSpace(name: "scroll")
			.onReceive(publisher) {
				print("Stopped on: \($0)")
			}
		}
	}
}

struct TestScrollDidEndDetect_Previews: PreviewProvider {
	static var previews: some View {
		TestScrollDidEndDetect()
	}
}
