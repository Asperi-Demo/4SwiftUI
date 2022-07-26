// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestTabViewBarAppearance: View {
	var body: some View {
		TabViewUnique()
	}
	
	struct TabViewUnique: View {
		init() {
			UITabBar.appearance().backgroundColor = UIColor(Color(#colorLiteral(red: 0.7137255072593689, green: 0.10196077823638916, blue: 0.10196077823638916, alpha: 1)))
			UITabBar.appearance().unselectedItemTintColor = UIColor.white
		}

		var body: some View {

			TabView() {
				Text("Tab 1")
					.tabItem {
						Image(systemName: "globe.americas.fill")
					}

				Text("Tab 2")
					.tabItem {
						Image(systemName: "bag")

					}
				Text("Tab 3")
					.tabItem {
						Image(systemName: "plus.square")
					}
				Text("Tab 4")
					.tabItem {
						Image(systemName: "person")
					}
			}.accentColor(.white)
		}
	}

}

struct TestTabViewBarAppearance_Previews: PreviewProvider {
	static var previews: some View {
		TestTabViewBarAppearance()
	}
}
