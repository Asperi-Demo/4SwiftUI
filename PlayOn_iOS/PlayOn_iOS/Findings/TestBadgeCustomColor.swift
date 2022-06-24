// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: 	By using this you agree do not repost any part of this code
//					on StackOverflow site. Thanks, Asperi.

import SwiftUI

struct TestBadgeCustomColor: View {
	init() {
		UITabBarItem.appearance().badgeColor = .purple
	}

	var body: some View {
		TabView {
			Color.green.overlay(Text("One"))
				.tabItem { Image(systemName: "car") }
				.badge(4)

			Text("Two")
				.tabItem { Image(systemName: "house") }
				.badge("A")
		}
	}
}

struct TestBadgeCustomColor_Previews: PreviewProvider {
    static var previews: some View {
        TestBadgeCustomColor()
    }
}
