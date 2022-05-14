// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard
//
// ATTENTION: 	By using this you agree do not repost any part of this code
//					on StackOverflow site. Thanks, Asperi.

import SwiftUI

struct TestTabBarShadow: View {
	func setupTabBar() {
		let appearance = UITabBarAppearance()
		appearance.shadowColor = .white
		appearance.shadowImage = UIImage(named: "tab-shadow")?.withRenderingMode(.alwaysTemplate)
		appearance.backgroundColor = UIColor.darkGray
		UITabBar.appearance().scrollEdgeAppearance = appearance
	}

	init() {
		setupTabBar()
	}

	var body: some View {
		TabView {
			Text("Markets").font(.title)
				.tag(1)
				.tabItem {
					Image(systemName: "chart.xyaxis.line")
					Text("Market")
				}

			Text("PortfolioTabBarView")
				.tag(2)
				.tabItem {
					Image(systemName: "bitcoinsign.square.fill")
					Text("Portfolio")
				}

			Text("SettingsTabBarView")
				.tag(3)
				.tabItem {
					Image(systemName: "gearshape.fill")
					Text("Settings")
				}
		}

	}
}

struct TestTabBarShadow_Previews: PreviewProvider {
	static var previews: some View {
		TestTabBarShadow()
			.preferredColorScheme(.dark)
	}
}
