// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestDropCancellingIntercept: View {
	var body: some View {
		ReorderingTestsView()
	}

	struct ReorderingTestsView: View {

		struct BookItem: Identifiable, Equatable {
			var id = UUID()
			var name: String
		}

		@State var draggingItem: BookItem?
		@State var items: [BookItem] = [
			BookItem(name: "Harry Potter"),
			BookItem(name: "Lord of the Rings"),
			BookItem(name: "War and Peace"),
			BookItem(name: "Peter Pane")
		]

		class MYItemProvider: NSItemProvider {
			var didEnd: (() -> Void)?
			deinit {
				print("[x] destroyed")
				didEnd?()
			}
		}

		var body: some View {
			VStack{
				ScrollView{
					VStack(spacing: 10){
						ForEach(items){ item in
							VStack{
								Text(item.name)
									.padding(8)
									.frame(maxWidth: .infinity)
							}
							.background(Color.gray)
							.cornerRadius(8)
							.opacity(item.id == draggingItem?.id ? 0.01 : 1) // <- HERE
							.onDrag {
								draggingItem = item
								let provider = MYItemProvider(contentsOf: URL(string: "\(item.id)"))!
								provider.didEnd = {
									DispatchQueue.main.async {
										draggingItem = nil
									}
								}
								print(">> created")
								return provider
							}
							.onDrop(of: [.item], delegate: DropViewDelegate(currentItem: item, items: $items, draggingItem: $draggingItem))
						}
					}
					.animation(.default, value: items)
				}
			}
			.padding(.horizontal)
		}

		struct DropViewDelegate: DropDelegate {

			var currentItem: BookItem
			var items: Binding<[BookItem]>
			var draggingItem: Binding<BookItem?>

			func performDrop(info: DropInfo) -> Bool {
				draggingItem.wrappedValue = nil // <- HERE
				return true
			}

			func dropEntered(info: DropInfo) {
				if currentItem.id != draggingItem.wrappedValue?.id {
					let from = items.wrappedValue.firstIndex(of: draggingItem.wrappedValue!)!
					let to = items.wrappedValue.firstIndex(of: currentItem)!
					if items[to].id != draggingItem.wrappedValue?.id {
						items.wrappedValue.move(fromOffsets: IndexSet(integer: from),
														toOffset: to > from ? to + 1 : to)
					}
				}
			}

			func dropUpdated(info: DropInfo) -> DropProposal? {
				return DropProposal(operation: .move)
			}
		}
	}
}

struct TestDropCancellingIntercept_Previews: PreviewProvider {
	static var previews: some View {
		TestDropCancellingIntercept()
	}
}
