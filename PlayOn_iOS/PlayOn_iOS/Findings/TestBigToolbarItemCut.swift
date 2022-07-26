// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestBigToolbarItemCut: View {
	var body: some View {
		ContentView()
	}
	
	struct ContentView: View {
		@State private var pos = CGPoint.zero
		@State private var visible = false
		@State private var isNavigated = false
		
		var body: some View {
			ZStack {
				NavigationView {
					
					NavigationLink(isActive: $isNavigated, destination: { View2() }) {
						Text("Go Next!")
							.padding()
							.navigationTitle("Title")
							.toolbar {
								Color.clear            // reserve space !!
									.frame(width: 150)
									.overlay(GeometryReader {// get global position !!
										Color.clear.preference(key: ViewPointKey.self,
																	  value: [$0.frame(in: .global).center])
									})
							}
					}
				}
				.onAppear {
					// fixes known NavigationView weird initial animation issue
					DispatchQueue.main.async { visible = true }
				}
// uncomment below if need to show only on first screen				
//				.onChange(of: isNavigated) { visible = !$0 }

				if visible {
					Circle().fill(Color.red)
						.frame(width: 150, height: 150)
						.position(x: pos.x, y: pos.y)     // align to toolbar item !!
				}
			}
			.ignoresSafeArea()
			.onPreferenceChange(ViewPointKey.self) {
				pos = $0.first ?? .zero
			}
			.animation(.default, value: pos)
			.animation(.default, value: visible)
		}
	}
	
	struct View2: View {
		var body: some View {
			Text("Hello, World!")
		}
	}
}

struct TestBigToolbarItemCut_Previews: PreviewProvider {
	static var previews: some View {
		TestBigToolbarItemCut()
	}
}
