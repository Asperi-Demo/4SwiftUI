// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestFillAsyncImagesInGrid: View {
	var body: some View {
		ContentView()
	}

	struct ContentView: View {
		@State private var results = [
			"https://source.unsplash.com/1600x900/?nature&\(Int.random(in: 1..<6236))",
			"https://source.unsplash.com/1600x900/?nature&\(Int.random(in: 1..<6236))",
			"https://source.unsplash.com/1600x900/?nature&\(Int.random(in: 1..<6236))",
			"https://source.unsplash.com/1600x900/?nature&\(Int.random(in: 1..<6236))",
			"https://source.unsplash.com/1600x900/?nature&\(Int.random(in: 1..<6236))",
			"https://source.unsplash.com/1600x900/?nature&\(Int.random(in: 1..<6236))",
			"https://source.unsplash.com/1600x900/?nature&\(Int.random(in: 1..<6236))",
			"https://source.unsplash.com/1600x900/?nature&\(Int.random(in: 1..<6236))",
		]

		let columns = [
			GridItem(.flexible(), spacing: 1),
			GridItem(.flexible(), spacing: 1),
			GridItem(.flexible(), spacing: 1),
		]
		@State private var selected: Image? = nil
		@State private var selectedID: String? = nil
		@Namespace var ns
		var body: some View {
			ZStack {
				ScrollView {
					LazyVGrid(columns: columns, spacing: 1) {
						ForEach(results, id: \.self) { result in
							Color.clear.overlay(
								AsyncImage(url: URL(string: result)) { phase in
									switch phase {
									case .success(let image):
										image
											.resizable()
											.scaledToFill()
											.onTapGesture {
												selectedID = result
												selected = image
											}
									default:
										Image(systemName: "photo")
									}
								}
							)
							.frame(maxWidth: .infinity)
							.aspectRatio(1, contentMode: .fit)
							.clipped()
						}
					}
				}
				if let image = selected {
					image
						.resizable()
						.aspectRatio(contentMode: .fill)
						.onTapGesture {
							selectedID = nil
							selected = nil
						}
						.zIndex(1)
				}
			}.animation(.default, value: selected)
		}
	}
}

struct TestFillAsyncImagesInGrid_Previews: PreviewProvider {
	static var previews: some View {
		TestFillAsyncImagesInGrid()
	}
}
