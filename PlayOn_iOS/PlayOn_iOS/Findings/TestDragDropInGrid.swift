// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI
import UniformTypeIdentifiers

struct TestDragDropInGrid: View {
	var body: some View {
		DemoDragRelocateView()
	}

	struct GridData: Identifiable, Equatable {
		let id: Int
	}

	//MARK: - Model

	class Model: ObservableObject {
		@Published var data: [GridData]

		let columns = [
			GridItem(.fixed(160)),
			GridItem(.fixed(160))
		]

		init() {
			data = Array(repeating: GridData(id: 0), count: 100)
			for i in 0..<data.count {
				data[i] = GridData(id: i)
			}
		}
	}

	//MARK: - Grid

	struct DemoDragRelocateView: View {
		@StateObject private var model = Model()

		@State private var dragging: GridData?
		@State private var isUpdating = false

		var body: some View {
			ScrollView {
				LazyVGrid(columns: model.columns, spacing: 32) {
					ForEach(model.data) { d in
						GridItemView(d: d)
							.overlay(dragging?.id == d.id && isUpdating ? Color.white.opacity(0.8) : Color.clear)
//							.contextMenu {  // menu works simultaneously with drag !
//								Button {
//									// some action here
//								} label: {
//									Label("Edit...", systemImage: "pencil")
//								}
//
//								// other options .....
//							}
							.onDrag {
								self.dragging = d
								return NSItemProvider(object: String(d.id) as NSString)
							}
							.onDrop(of: [UTType.text], delegate: DragRelocateDelegate(item: d, listData: $model.data, current: $dragging, updating: $isUpdating))
					}
				}.animation(.default, value: model.data)
			}
		}
	}

	struct DragRelocateDelegate: DropDelegate {
		let item: GridData
		@Binding var listData: [GridData]
		@Binding var current: GridData?
		@Binding var updating: Bool

		func dropEntered(info: DropInfo) {
			updating = true
			if item != current {
				let from = listData.firstIndex(of: current!)!
				let to = listData.firstIndex(of: item)!
				if listData[to].id != current!.id {
					listData.move(fromOffsets: IndexSet(integer: from),
									  toOffset: to > from ? to + 1 : to)
				}
			}
		}

		func dropUpdated(info: DropInfo) -> DropProposal? {
			return DropProposal(operation: .move)
		}

		func performDrop(info: DropInfo) -> Bool {
			self.updating = false
			self.current = nil
			return true
		}
	}

	//MARK: - GridItem

	struct GridItemView: View {
		var d: GridData

		var body: some View {
			VStack {
				Text(String(d.id))
					.font(.headline)
					.foregroundColor(.white)
			}
			.frame(width: 160, height: 240)
			.background(Color.green)
		}
	}

}

struct TestDragDropInGrid_Previews: PreviewProvider {
	static var previews: some View {
		TestDragDropInGrid()
	}
}
