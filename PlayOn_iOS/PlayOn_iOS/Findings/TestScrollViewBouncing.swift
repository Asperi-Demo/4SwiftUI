// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: 	By using this you agree do not repost any part of this code
//					on StackOverflow site. Thanks, Asperi.

import SwiftUI

struct TestScrollViewBouncing: View {
	var body: some View {
		ContentView()
	}

	struct ContentView: View {
		var body: some View {
			GeometryReader { geo in
				ScrollView {
					Rectangle()
						.frame(width: geo.size.width, height: 1800)
						.foregroundColor(.black)
						.background(ScrollViewConfigurator {
							$0?.bounces = false               // << here !!
						})
					Spacer()
				}
			}
		}
	}

	struct ScrollViewConfigurator: UIViewRepresentable {
		let configure: (UIScrollView?) -> ()
		func makeUIView(context: Context) -> UIView {
			let view = UIView()
			DispatchQueue.main.async {
				configure(view.enclosingScrollView())
			}
			return view
		}

		func updateUIView(_ uiView: UIView, context: Context) {}
	}
}

struct TestScrollViewBouncing_Previews: PreviewProvider {
	static var previews: some View {
		TestScrollViewBouncing()
	}
}
