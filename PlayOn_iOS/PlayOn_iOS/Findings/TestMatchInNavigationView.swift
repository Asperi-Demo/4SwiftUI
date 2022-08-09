// 🔥BOYCOTT on russia - terrorist must be punished!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestMatchInNavigationView: View {
	var body: some View {
		ListView()
	}

	struct ListView: View {
		@State private var selectedCard: Model?
		@State private var isShowingCard: Bool = false
		@Namespace var animation

		let mockItems: [Model] = [
			Model(title: "Test title 1", colour: .gray),
			Model(title: "Test title 2", colour: .blue),
			Model(title: "Test title 3", colour: .purple)
		]

		var body: some View {
			NavigationView {
				ZStack {
					if let selectedCard = selectedCard, isShowingCard {
						DetailView(
							isShowingDetail: $isShowingCard,
							item: selectedCard,
							animation: animation
						)
					} else {
						ScrollView(.vertical, showsIndicators: false) {
							ForEach(mockItems) { item in
								CardView(item: item)
									.matchedGeometryEffect(id: item.id, in: animation)
									.onTapGesture {
										selectedCard = item
										isShowingCard = true
									}
							}
						}
						.navigationTitle("Test title")
					}
				}
				.padding(.horizontal)
				.navigationViewStyle(.stack)
				.navigationBarTitleDisplayMode(.large)
				.animation(.default, value: isShowingCard)
			}
		}
	}

	struct Model: Identifiable {
		let id = UUID().uuidString
		//  let icon: String
		let title: String
		//  let account: String
		let colour: Color
	}

	struct CardView: View {
		let item: Model
		var body: some View {
			VStack {
				Text(item.title)
					.font(.title3)
					.fontWeight(.heavy)
			}
			.padding()
			.frame(maxWidth: .infinity, minHeight: 100, alignment: .leading)
			.background(item.colour)
			.foregroundColor(.white)
			.clipShape(RoundedRectangle(cornerRadius: 12))
		}
	}

	struct DetailView: View {
		@Binding var isShowingDetail: Bool
		let item: Model
		let animation: Namespace.ID
		var body: some View {
			VStack {
				CardView(item: item)
					.matchedGeometryEffect(id: item.id, in: animation)
					.onTapGesture {
						isShowingDetail = false
					}
				ScrollView(.vertical, showsIndicators: false) {
					Text("Lorem ipsum dolor...")
				}
			}
			.padding(.horizontal)
			.navigationBarTitleDisplayMode(.inline)
			.navigationViewStyle(.stack)
		}
	}

}

struct TestMatchInNavigationView_Previews: PreviewProvider {
	static var previews: some View {
		TestMatchInNavigationView()
	}
}
