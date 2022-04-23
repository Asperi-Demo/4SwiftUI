// BOYCOTT on ᵣussia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard
//
// ATTENTION: 	By using this you agree do not repost any part of this code
//					on StackOverflow site. Thanks, Asperi.

import SwiftUI

struct TestPersistentOpaqueNavBar: View {
	var body: some View {
		ContentView()
	}

	struct ContentView: View {

		init() {
			let navBarAppearance = UINavigationBarAppearance()
			navBarAppearance.configureWithOpaqueBackground()
			UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
		}

		var body: some View {

			NavigationView {
				ZStack {
					Color.green.edgesIgnoringSafeArea(.all)
					NavigationLink(destination: Color.green.edgesIgnoringSafeArea(.all)) {
						Text("Go to details ->")
					}
				}
				.navigationBarItems(trailing: Button(action: {}) {
					Image(systemName: "gear")
						.font(.title2)
				}
				)
				.navigationBarTitle("Title", displayMode: .inline)
			}.accentColor(.red)
		}
	}
}

struct TestPersistentOpaqueNavBar_Previews: PreviewProvider {
	static var previews: some View {
		TestPersistentOpaqueNavBar()
	}
}
