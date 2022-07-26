// 🔥BOYCOTT on russia - terrorist must be punished!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestNoNavigationBarTabView: View {
	var body: some View {
		BaseView()
	}

	struct BaseView: View {
		@State private var showRoot = false
		var body: some View {
			ZStack {
				if showRoot {
					RootTabNavView()
						.transition(.move(edge: .trailing))
				} else {
					NavigationView {
						ZStack {
							Color.gray
							VStack{
								Text("Root Navigation View").padding()
								Button(action: { showRoot = true }) {
									Text("To New Root View")
								}.padding()
								NavigationLink(destination: TestDetailView()) {
									Text("To a detail view")
								}.padding()
							}
						}
						.navigationTitle("")        // << hide !!
						.navigationBarHidden(true)  // << hide !!
					}
					.transition(.asymmetric(insertion: .identity, removal: .move(edge: .leading)))
				}
			}.animation(.default, value: showRoot)
		}
	}

	struct RootTabNavView: View {
		var body: some View {
			TabView {
				TestTabView1()
					.tabItem {
						Text("1")
					}
				TestTabView2()
					.tabItem {
						Text("2")
					}
			}
		}
	}

	struct TestTabView1: View {
		var body: some View {
			ZStack {
				Color.red
				Text("Test Tab View 1 (New Nav Root / Hidden Navigation)")
			}
		}
	}

	struct TestTabView2: View {
		var body: some View {
			NavigationView {
				ZStack {
					Color.green
					NavigationLink (destination: TestDetailView()) {
						Text("To a detail view")
					}
				}
				.navigationTitle("")             // << hide !!
				.navigationBarHidden(true)       // << hide !!
			}
		}
	}

	struct TestDetailView: View {
		var body: some View {
			ZStack {
				Color.purple
				Text("A Dismissable Detail")
			}
			.navigationBarTitleDisplayMode(.inline)  // << depending on needs !!
		}
	}

}

struct TestNoNavigationBarTabView_Previews: PreviewProvider {
	static var previews: some View {
		TestNoNavigationBarTabView()
	}
}
