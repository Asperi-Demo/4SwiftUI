// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestTransferBindingIntoSheet: View {
	var body: some View {
		CarListView()
	}

	struct Car: Identifiable {
		let id = UUID().uuidString
		var model: String = "Untitled"
		var color: String = "Untitled"
	}

	class CarModelView: ObservableObject {
		@Published var cars: [Car] = [
			.init(model: "Audi A8", color: "Red"),
			.init(model: "Honda Civic", color: "Blue"),
			.init(model: "BMW M3", color: "Black"),
			.init(model: "Toyota Supra", color: "Orange")
		]
	}

	struct CarListView: View {

		@StateObject var vm = CarModelView()

// We don't need binding to state here, because it will edit nothing (after sheet close - state will be dropped, so all changes will be lost). Instead we need to transfer a binding to view model item into sheet.
//
// A possible solution is to iterate over view model bindings and use state of binding as activator to inject it as sheet's item into content.

		@State var editingCar: Binding<Car>?    // << here !!

		var body: some View {
			List {
				ForEach($vm.cars) { car in     // << binding !!
					VStack(alignment: .leading) {
						Text(car.wrappedValue.model)
							.font(.headline)
						Text(car.wrappedValue.color)
							.font(.callout)
					}
					.swipeActions(edge: .trailing) {
						Button {
							setEditing(car: car)  // << binding !!
						} label: {
							Label("Edit", systemImage: "pencil.circle")
						}
					}
				}

			}
			.sheet(item: $editingCar) {   // << sheet is here !!
				resetEditingCar()
			} content: {
				SheetView(editingCar: $0)  // non-optional binding !!!
			}
			.environmentObject(vm)
		}

		func setEditing(car: Binding<Car>) {
			editingCar = car
			print("Editing car is set: \(String(describing: editingCar?.model))")
		}

		func resetEditingCar() {
			editingCar = nil
			print("Editing car should be nil: \(String(describing: editingCar?.model))")
		}
	}

	struct SheetView: View {
		@Binding var editingCar: Car

		var body: some View {
			VStack {
				Text("Edit Car Data")
				TextField("Model", text: $editingCar.model)
				TextField("Color", text: $editingCar.color)
			}
		}
	}
}

struct TestTransferBindingIntoSheet_Previews: PreviewProvider {
	static var previews: some View {
		TestTransferBindingIntoSheet()
	}
}
