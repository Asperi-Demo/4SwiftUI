// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI
import Combine

struct TestUpdateOnPartOfModelChange: View {
	var body: some View {
		ContentView()
	}

	struct SomeItem {
		let id: Int
		var text: String
	}

	final class SomeViewModel: ObservableObject {
		@Published var items = [
			SomeItem(id: 0, text: "Zero"),
			SomeItem(id: 1, text: "One")
		]

		@State var cancellables = [AnyCancellable]()

		init() {
			observe()
		}

		/// Observe changes of items so I can post updates to the server when one changes.
		///
		/// Potentially something like the following, but arrays dont work like this:
		///```
		/// items
		///   .publisher
		///   .debounce(for: 0.2, scheduler: DispatchQueue.main)
		///   .sink { change in
		///     updateItem(with: change.id)
		///   }
		///   .store(in: &cancellables)
		/// ```
		func observe() {
			// ..
		}

		/// Updates an item on server.
		func updateItem(with id: Int) {
			// ..
		}
	}

	struct ContentView: View {
		@StateObject private var viewModel = SomeViewModel()

		var body: some View {
			List(viewModel.items, id: \.id) {
				Text($0.text)
			}
			List($viewModel.items, id: \.id) { $item in
				let binding = Binding(
					get: { item.text },
					set: {
						item.text = $0
						// push item in some queue for delayed background update to server
						// enqueueUpdateItem(with: item.id)  // or even all `item`
					}
				)
				TextField("text", text: binding)
			}
		}
	}

}

struct TestUpdateOnPartOfModelChange_Previews: PreviewProvider {
	static var previews: some View {
		TestUpdateOnPartOfModelChange()
	}
}
