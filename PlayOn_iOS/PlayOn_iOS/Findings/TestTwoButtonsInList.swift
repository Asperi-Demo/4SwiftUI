// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestTwoButtonsInList: View {
	var body: some View {
		MainView { _ in }
	}

	private enum MenuItem: String, Identifiable, CaseIterable {
		var id: String {
			self.rawValue
		}

		case option1
		case option2
		case option3
		case option4
	}

	private struct MainView: View {

		let onSelect: (MenuItem) -> Void

		var body: some View {
			VStack(spacing: 0) {
				Text("Demo")
					.padding(16)
				List {
					Section("hello") {
						ForEach(MenuItem.allCases) { item in
							ZStack(alignment: .topLeading) {
								// added custom button style disables activate
								// of default list row highlight on tap
								Button("") {
									print("yes", item)
								}
								.buttonStyle(MyStyle())    // << here !!

								VStack(alignment: .leading, spacing: 5) {
									Text(item.rawValue).font(.title2)
									Text("something here").font(.body)
									Button("Hello") {
										print("no", item)
									}.buttonStyle(BorderedButtonStyle())

								}
								.contentShape(Rectangle())
								.padding(.horizontal)
								.padding(.top, 10)
								.padding(.bottom, 10)
							}
						}
					}
					.listRowInsets(EdgeInsets())

				}.listStyle(.plain)

			}.onAppear {
				UITableViewCell.appearance().selectedBackgroundView = {
					let view = UIView()
					view.backgroundColor = .blue
					return view
				}()
			}
		}
	}

	struct MyStyle: ButtonStyle {
		func makeBody(configuration: Configuration) -> some View {
			configuration.label
				.frame(maxWidth: .infinity, maxHeight: .infinity)
				.contentShape(Rectangle())
				.background(
					configuration.isPressed ? Color.secondary : Color.clear
				)
		}
	}
}

struct TestTwoButtonsInList_Previews: PreviewProvider {
	static var previews: some View {
		TestTwoButtonsInList()
	}
}
