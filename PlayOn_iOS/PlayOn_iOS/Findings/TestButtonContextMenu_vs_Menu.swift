// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: 	By using this you agree do not repost any part of this code
//					on StackOverflow site. Thanks, Asperi.

import SwiftUI

struct TestButtonContextMenu_vs_Menu: View {
	var body: some View {
		ContentView()
	}

	struct ContentView: View {
		@State private var isAutoRefresh = true

		var body: some View {
			NavigationView {
				VStack {
					Picker(selection: self.$isAutoRefresh, label: Text("")) {
						Text("Manual refresh").tag(false)
						Text("Auto refresh").tag(true)
					}
					.pickerStyle(InlinePickerStyle())

					Text("Auto refresh is: \(String(isAutoRefresh))")
				}
				.navigationBarTitle("Demo")
				.navigationBarItems(
					leading:
						Menu {
							Button("Go") {}
							Picker(selection: self.$isAutoRefresh, label: Text("")) {
								Text("Manual refresh").tag(false)
								Text("Auto refresh").tag(true)
							}
							.pickerStyle(InlinePickerStyle())
						} label: {
							Image(systemName: "arrow.clockwise")
						},
					trailing:
					Button(action: {}, label: {
						 Image(systemName: "arrow.clockwise")
					})
					.contextMenu {
						 Picker(selection: self.$isAutoRefresh, label: Text("")) {
							  Text("Manual refresh").tag(false)
							  Text("Auto refresh").tag(true)
						 }
						 .pickerStyle(InlinePickerStyle())
					}.id(isAutoRefresh)
				)
			}
		}
	}
}

struct TestButtonContextMenu_vs_Menu_Previews: PreviewProvider {
	static var previews: some View {
		TestButtonContextMenu_vs_Menu()
	}
}
