// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestAsyncProgressInList: View {
	var body: some View {
		ContentView()
	}

	struct ContentView: View {
		let items = 0..<100

		var body: some View {
			NavigationView {
				List(items, id: \.self) { _ in
					VStack {
						AsyncDataView()
					}
				}
				Text("Middle Panel")
			}
		}
	}

	struct AsyncDataView: View {
		@StateObject private var vm = ViewModel()

		fileprivate class ViewModel: ObservableObject {
			@Published var data: String?

			init() {
				update()
			}

			func update() {
				Task.detached {
					try? await Task.sleep(nanoseconds: 1_000_000_000)

					await MainActor.run {
						self.data = String(Int.random(in: 0..<100))
					}
				}
			}
		}

		var body: some View {
			if let data = vm.data {
				Text(data)
			}
			else {
				ProgressView()
			}
		}
	}
}

struct TestAsyncProgressInList_Previews: PreviewProvider {
	static var previews: some View {
		TestAsyncProgressInList()
	}
}
