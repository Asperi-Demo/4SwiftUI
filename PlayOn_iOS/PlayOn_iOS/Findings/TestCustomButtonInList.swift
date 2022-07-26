// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestCustomButtonInList: View {
	var body: some View {
		ExampleView()
	}
	struct ExampleView: View {

		var body: some View {
			NavigationView {
				List {
					Section {
						Text("Info")
					}

					Section {
						Button("Save") {
							print("pressed")
						}
						.buttonStyle(BlueButtonStyle())
						.listRowInsets(EdgeInsets())    // for iOS15+
					}
				}
				//.listStyle(InsetGroupedListStyle())  // for <iOS15
				.environment(\.horizontalSizeClass, .regular)
				.navigationBarTitle(Text("Title"))
			}
		}
	}
	
	struct BlueButtonStyle: ButtonStyle {

		func makeBody(configuration: Self.Configuration) -> some View {
			configuration.label
				.font(.headline)
				.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
				.contentShape(Rectangle())
				.foregroundColor(configuration.isPressed ? Color.white.opacity(0.5) : Color.white)
				// for iOS15+
				.background(configuration.isPressed ? Color.blue.opacity(0.5) : Color.blue)
				// outdated: <iOS15
				//.listRowBackground(configuration.isPressed ? Color.blue.opacity(0.5) : Color.blue)
		}
	}

}

struct TestCustomButtonInList_Previews: PreviewProvider {
	static var previews: some View {
		TestCustomButtonInList()
	}
}
