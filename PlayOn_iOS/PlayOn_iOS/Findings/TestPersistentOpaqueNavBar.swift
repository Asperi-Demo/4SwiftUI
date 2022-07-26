// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

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
