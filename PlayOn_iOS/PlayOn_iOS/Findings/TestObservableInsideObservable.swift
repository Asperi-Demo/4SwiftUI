// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestObservableInsideObservable: View {
	final class NavigationModel: ObservableObject {
		@Published var selectedItem = ""
		@Published var items: [String] = [
			"Button 1", "Button 2", "Button 3"
		]
	}

	struct NavigationMenu: View {

		@ObservedObject var viewModel: NavigationModel

		var body: some View {
			HStack {
				ForEach(0..<3, id: \.self) { index in
					let title = viewModel.items[index]
					Button {
						withAnimation {
							viewModel.selectedItem = title
						}
					} label: {
						Text(title)
							.font(.system(.body))
							.padding()
							.foregroundColor(
								viewModel.selectedItem == title ? .white : .black
							)
							.background(viewModel.selectedItem == title ? .black : .yellow)
					}
				}
			}
		}
	}

	final class TabViewModel: ObservableObject {
		var navModel = NavigationModel()
	}

	@ObservedObject var viewModel = TabViewModel()

	var body: some View {
		parentView
	}

	private var parentView: some View {
		VStack(spacing: 0) {
			Spacer()
			NavigationMenu(viewModel: viewModel.navModel)
			PageView(navModel: viewModel.navModel)
		}
		.onReceive(viewModel.navModel.$selectedItem) { output in
			print("Button tapped:", output)
		}
	}

	struct PageView: View {
		@ObservedObject var navModel: NavigationModel

		var body: some View {
			pageView
		}

		private var pageView: some View {
			TabView(selection: $navModel.selectedItem) {
				ForEach(0..<3, id: \.self) { index in
					let tag = navModel.items[index]
					item(tag: tag)
						.tag(tag)
				}
			}
			.tabViewStyle(.page(indexDisplayMode: .never))
			.transition(.slide)
		}

		private func item(tag: String) -> some View {
			VStack {
				Text("PAGE: " + tag)
			}
			.frame(maxWidth: .infinity, maxHeight: .infinity)
			.background(Color.red)
		}
	}

}


struct TestObservableInsideObservable_Previews: PreviewProvider {
	static var previews: some View {
		TestObservableInsideObservable()
	}
}
