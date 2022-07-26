// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestColorShemeForView: View {
	var body: some View {
		ContentView()
	}
	struct ContentView: View {
		var body: some View {
			//		TestView()        // << replace with test module to run !!
			
			NavigationView {
				ZStack {
					List(0..<10) {
						Text("Item \($0)")
					}
					NavigationLink(isActive: .constant(false)) {
						Text("TestView")
					} label: {
						EmptyView()
					}
					
					NavigationLink(isActive: .constant(false)) {
						Text("TestView")
					} label: {
						EmptyView()
					}
					
				}.overlay(
					Text("LoadingView")
						.padding(40)
						.background(Color(uiColor: UIColor.systemBackground))
					//.preferredColorScheme(.dark)  // << applied to entire window !!
						.colorScheme(.dark)    // << still works !!
				)
			}
		}
	}
}

struct TestColorShemeForView_Previews: PreviewProvider {
	static var previews: some View {
		TestColorShemeForView()
	}
}
