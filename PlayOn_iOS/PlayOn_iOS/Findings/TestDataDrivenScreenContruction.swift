// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestDataDrivenScreenContruction: View {
	var body: some View {
		MainScreen()
	}
	
	struct Screen<Content: View>: View, Identifiable {
		var id: String {
			return title
		}
		
		let title: String
		let destination: Content
		
		var body: some View {
			NavigationLink(destination: destination) {
				Text(title)
			}
		}
	}
	
	enum AllScreens: CaseIterable, Identifiable {
		
		case charts, navStack
		
		var id: Self { self }
		
		@ViewBuilder var view: some View {
			switch self {
			case .charts:
				Screen(title: "Charties", destination: SwiftChartsScreen())
			case .navStack:
				Screen(title: "Test", destination: NavStackScreen())
			}
		}
	}
	
	struct MainScreen: View {
		var body: some View {
			NavigationView {
				List(AllScreens.allCases) {
					$0.view
				}
				.navigationTitle("WWDC 22")
			}
		}
	}
	
	struct SwiftChartsScreen: View {
		var body: some View {
			Text("SwiftChartsScreen")
		}
	}
	
	struct NavStackScreen: View {
		var body: some View {
			Text("NavStackScreen")
		}
	}
	
}

struct TestDataDrivenScreenContruction_Previews: PreviewProvider {
	static var previews: some View {
		TestDataDrivenScreenContruction()
	}
}
