// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestTabBarShadow: View {
	func setupTabBar() {
		let appearance = UITabBarAppearance()
		appearance.shadowColor = .red
		appearance.shadowImage = UIImage(named: "tab-shadow")?.withRenderingMode(.alwaysTemplate)
		appearance.backgroundColor = UIColor.black
		UITabBar.appearance().scrollEdgeAppearance = appearance
	}

	init() {
		setupTabBar()
	}

	var body: some View {
		ZStack(alignment: .bottom) {
			TabView {
				Text("Markets").font(.title)
					.tag(1)
					.tabItem {
						Image(systemName: "chart.xyaxis.line")
						Text("Market")
					}

				Text("PortfolioTabBarView")
					.tag(2)
//					.tabItem {
//						Image(systemName: "bitcoinsign.square.fill")
//						Text("Portfolio")
//					}

				Text("SettingsTabBarView")
					.tag(3)
					.tabItem {
						Image(systemName: "gearshape.fill")
						Text("Settings")
					}
			}
			Circle().fill(.background)
				.frame(width: 80, height: 80)
				.overlay(GeometryReader { gp in
					Color.clear.overlay(
						Image(systemName: "bitcoinsign.square")
							.resizable().foregroundColor(.secondary)
							.frame(width: gp.size.width * 0.4, height: gp.size.height * 0.4)
					)
				})
				.compositingGroup()
				.shadow(color: .red.opacity(0.5), radius: 6, x: 0, y: 0)
				.onTapGesture {
					// manipulate with TabView selection here !!
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
