// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI
import Combine

struct TestObservingAppStorageInVM: View {
	var body: some View {
		ContentView()
	}

	struct ContentView: View {
		@StateObject var vm = ValueViewModel()
		@AppStorage("MyValue") var myValue = 0

		var body: some View {
			VStack {
				Text("Title: " + vm.title)
				Button("Generage") {
					myValue = Int.random(in: 1...100)
				}
				.onChange(of: vm.foo) {
					print("Change >> \($0)")
				}
				.onReceive(vm.$foo) {
					print("Event: \($0)")
				}
			}
		}
	}

	class AppSettings: ObservableObject {
		@AppStorage("MyValue") var myValue = 0
		@AppStorage("foo") var foo = "default"
	}

	class ValueViewModel: ObservableObject {
		private var settings = AppSettings()

		@Published var title: String = ""
		@Published var foo: String = "default" { didSet { print(foo) } }

		private var cancellable: AnyCancellable?

		init() {
			cancellable = settings.objectWillChange.sink { [weak self] _ in
				guard let self = self else { return }
				self.title = "Hello \(self.settings.myValue)"
				self.foo = self.settings.foo
			}
		}
	}
}

struct TestObservingAppStorageInVM_Previews: PreviewProvider {
	static var previews: some View {
		TestObservingAppStorageInVM()
	}
}
