// 🔥BOYCOTT on russia - terrorist must be punished!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI
import CoreMedia
import WebKit

struct ContentView: View {
	@EnvironmentObject var sceneDelegate: SceneDelegate
	var body: some View {
		// Replace any below with test module to demo !!
		if #available(iOS 16.0, *) {
			EmptyView()
		} else {
			TestAlternateDestinations()
			//            MyAnyView(VStack {
			//            	Text("Hello")
			//			})
		}
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}

// MARK: -
struct MyAnyView: View {

	struct ViewHolder<V: View>: View {
		var body: V
	}

	init<V: View>(_ view: V) {
		ViewHolder(body: view)
	}

	var body: some View {
		getView()
	}

	@ViewBuilder private func getView() -> some View {
		//		if let view = holder.view as holder.type {
		//			return view
		//		}
	}
}
// MARK: -
struct TestAnimationInChangedContainer: View {
	@State private var showPlanet = false

	var body: some View {
		VStack {
			Button("Toggle") { showPlanet.toggle() }
			if showPlanet {
				MyPlanetView()
			}
		}
		.frame(maxHeight: .infinity, alignment: .top)
	}

	struct MyPlanetView: View {
		@State private var isAnimating = false  // << state !!
		@State private var shouldGo = false

		var height: CGFloat = 100 		// planet size
		static var position: CGFloat {
			[0.25, 0.5, 0.75, 0.3, 0.6].randomElement()! as CGFloat
		}


		var body: some View {
			GeometryReader { gp in
				VStack(spacing: 0) {
					if !shouldGo {
						Text("To be removed!")
							.frame(maxWidth: .infinity, maxHeight: gp.size.height * Self.position)
							.background(.yellow).zIndex(1)
					}
					Image(systemName: "globe")
						.resizable().scaledToFit().frame(width: height)
						.position(x: gp.size.width / 2.0, y: isAnimating ? gp.size.height : 0 )
						.animation(Animation.easeInOut(duration: 5.0).repeatForever(autoreverses: true), value: isAnimating)
	//					.frame(maxHeight: shouldGo ? .infinity : height)
	//					.frame(height:gp.size.height,
	//						alignment: isAnimating ? .bottom : .top)   // << switch !!
						.border(.green, width: 2)
						.onAppear {
							//						isAnimating = true   // << activate !!
							DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
								isAnimating = true   // << activate !!
							}
						}
				}
				.frame(maxHeight: gp.size.height)
				.contentShape(Rectangle())
				.onTapGesture {
					shouldGo.toggle()
				}
			}
		}
	}
}

struct NewView1: View {
	@State private var expand = false

	var body: some View {

		HStack {
			VStack{
				Text("Dropdown").onTapGesture{
					self.expand.toggle()
				}
				VStack {
					if expand {
						Text("Dropdown Item 1")
						Text("Dropdown Item 2")
					}
				}
				.alignmentGuide(VerticalAlignment.center) { $0[.top] }
			}
			.padding(10)
			.background(Color.green)
			.cornerRadius(10)
			.animation(.spring(), value: expand)
		}.frame(alignment: .top)

	}
}


// MARK: -
