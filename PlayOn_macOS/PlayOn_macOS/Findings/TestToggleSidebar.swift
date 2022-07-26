// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestToggleSidebar: View {
	@State private var collapsed = false
	var body: some View {
		NavigationView {
			VStack {
				List {
					NavigationLink("Show", destination: DetailsView(collapsed: collapsed))
				}
			}
			.background(SplitViewAccessor(sideCollapsed: $collapsed))

			DetailsView(collapsed: collapsed)
		}
	}

	struct DetailsView: View {
		let collapsed: Bool
		var body: some View {
			VStack(spacing: 24) {
				Text("Sidebar: \(collapsed ? "collapsed" : "expanded")")
				Button("Toggle") {
					NSApp.keyWindow?.firstResponder?.tryToPerform(
						#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
				}
			}
		}
	}
}

struct TestToggleSidebar_Previews: PreviewProvider {
	static var previews: some View {
		TestToggleSidebar()
	}
}
