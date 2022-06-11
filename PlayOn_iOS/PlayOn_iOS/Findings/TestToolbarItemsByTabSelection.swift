// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: 	By using this you agree do not repost any part of this code
//					on StackOverflow site. Thanks, Asperi.

import SwiftUI

struct TestToolbarItemsByTabSelection: View {
	var body: some View {
		ContentView()
	}

	struct ContentView: View {
		@State private var selection = 0
		var body: some View {
			NavigationView {
				NavigationLink() {
					TabView(selection: $selection) {
						Text("triangle")
							.tabItem {
								Label("triangle", systemImage: "triangle")
							}.tag(0)

						Text("square")
							.tabItem {
								Label("square", systemImage: "square")
							}.tag(1)

						Text("circle")
							.tabItem {
								Label("circle", systemImage: "circle")
							}.tag(2)
					}
					.navigationTitle("Tabs")
					.toolbar {
						ToolbarItemGroup(placement: .navigationBarTrailing) {
							if selection == 2 {
								Button("About") {
									print("About tapped!")
								}

								Button("Help") {
									print("Help tapped!")
								}
							}
						}
					}
				} label: {
					Text("Hello!")
				}
				.navigationTitle("Title")
			}
		}
	}
}

struct TestToolbarItemsByTabSelection_Previews: PreviewProvider {
	static var previews: some View {
		TestToolbarItemsByTabSelection()
	}
}
