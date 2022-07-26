// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestAppStorageInVM: View {
	var body: some View {
		ContentView()
	}

	class MyVM: ObservableObject {
		@AppStorage("isSelected") var selected = false {
			willSet {
				print(">> Get willSet") // << only for direct !!
			}
			didSet {
				print(">> Get didSet") // << only for direct !!
			}
		}
	}

	struct ContentView: View {
		@StateObject private var vm = MyVM()

		var body: some View {
			VStack {
				Button("External Toggle") {
					UserDefaults.standard.set(!vm.selected, forKey: "isSelected")
				}
				Button("Direct Toggle") {
					vm.selected.toggle()
				}
				Divider()
				Text(vm.selected ? "Selected" : "None")   // << works here
			}
			.onReceive(vm.objectWillChange) {
				// << got here twice for direct property changes !!
				// << got here once for external UserDefaults changes !!
				print(">> Get onReceive")
			}
		}
	}
}

struct TestAppStorageInVM_Previews: PreviewProvider {
	static var previews: some View {
		TestAppStorageInVM()
	}
}
