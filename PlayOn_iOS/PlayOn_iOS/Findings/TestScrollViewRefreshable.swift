// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: 	By using this you agree do not repost any part of this code
//					on StackOverflow site. Thanks, Asperi.

import SwiftUI

struct TestScrollViewRefreshable: View {
	var body: some View {
		ContentView()
	}
	
	struct ContentView: View {
		var body: some View {
			ScrollView {
				RefreshableView()
			}
			.refreshable {     // << injects environment value !!
				await fetchSomething()
			}
		}

		func fetchSomething() async {
			// demo, assume we update something long here
			try? await Task.sleep(nanoseconds: 10 * 1_000_000_000)
		}
	}

	struct MyProgress: View {
		@State private var isProgress = false
		var body: some View {
			HStack{
				 ForEach(0...4, id: \.self){index in
					  Circle()
							.frame(width:10,height:10)
							.foregroundColor(.red)
							.scaleEffect(self.isProgress ? 1:0.01)
							.animation(self.isProgress ? Animation.linear(duration:0.6).repeatForever().delay(0.2*Double(index)) :
								 .default
							, value: isProgress)
				 }
			}
			.onAppear { isProgress = true }
			.padding()
		}
	}

	struct RefreshableView: View {
		@Environment(\.refresh) private var refresh   // << refreshable injected !!

		@State private var isRefreshing = false

		var body: some View {
			VStack {
				if isRefreshing {
					MyProgress()    // ProgressView() ?? - no, it's boring :)
						.transition(.scale)
				}

				// simple demo card
				RoundedRectangle(cornerRadius: 20)
					.fill(.red).frame(height: 100).padding()
					.overlay(Text(isRefreshing ? "Refreshing" : "Ok"))
					.foregroundColor(.white)
			}
			.animation(.default, value: isRefreshing)
			.background(GeometryReader {
				// detect Pull-to-refresh
				Color.clear.preference(key: ViewOffsetKey.self, value: -$0.frame(in: .global).origin.y)
			})
			.onPreferenceChange(ViewOffsetKey.self) {
				if $0 < -80 && !isRefreshing {   // << any creteria we want !!
					isRefreshing = true
					Task {
						await refresh?()           // << call refreshable !!
						await MainActor.run {
							isRefreshing = false
						}
					}
				}
			}
		}
	}
}

struct TestScrollViewRefreshable_Previews: PreviewProvider {
	static var previews: some View {
		TestScrollViewRefreshable()
	}
}
