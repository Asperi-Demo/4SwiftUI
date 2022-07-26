// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

// Targeted for iPadOS app
struct TestNavigationDetailsWithPersistedView: View {
	var body: some View {
		ContentView()
	}

	struct ContentView: View {
		var body: some View {
			NavigationView {
				List {
					NavigationLink { DetailsView { DiscoverView() } }
				label: { Label("Discover", systemImage: "magnifyingglass") }
					NavigationLink { DetailsView {SongsView() } }
				label: { Label("Songs", systemImage: "music.note") }
					NavigationLink { DetailsView {ArtistsView() } }
				label: { Label("Artists", systemImage: "music.mic") }
				}
				.navigationBarHidden(true)
				.listStyle(SidebarListStyle())
				DetailsView { SongsView() }
			}
		}
	}

	struct DetailsView<V: View>: View {
		@ViewBuilder var content: () -> V
		var body: some View {
			VStack(spacing: 0) {
				AlwaysStayView()
				content()
			}
			.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
			.navigationBarHidden(true)
			.border(.blue)
		}
	}

	struct AlwaysStayView: View {

		var body: some View {
			Rectangle().fill(.red)
				.frame(height: 80)
		}
	}

	struct DiscoverView: View {

		var body: some View {
			Text("Discovery")
		}
	}

	struct SongsView: View {

		var body: some View {
			Text("Songs")
		}
	}

	struct ArtistsView: View {

		var body: some View {
			Text("Artists")
		}
	}
}

struct TestNavigationDetailsWithPersistedView_Previews: PreviewProvider {
	static var previews: some View {
		TestNavigationDetailsWithPersistedView()
	}
}
