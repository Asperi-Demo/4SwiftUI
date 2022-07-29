// 🔥BOYCOTT on russia - terrorist must be punished!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestInjectingAlertInPickerChanges: View {
	@State private var favoriteColor = 0
	@State private var toConfirm: Int?
	@State private var showAlert = false

	var selected: Binding<Int> {
		Binding<Int>(
			get: { favoriteColor },
			set: {
				toConfirm = $0
				showAlert = true
			}
		)
	}
	var body: some View {
		VStack {
			Picker("What is your favorite color?", selection: selected) {
				Text("Red").tag(0)
				Text("Green").tag(1)
			}
			.pickerStyle(.segmented)
			.alert("By changing color also modifieds other things...change color?", isPresented: $showAlert, presenting: toConfirm) { color in
				Button("YES") {
					favoriteColor = color
				}
				Button("Cancel") {
					// do nothing
				}
			}
		}
	}
}

struct TestInjectingAlertInPickerChanges_Previews: PreviewProvider {
    static var previews: some View {
        TestInjectingAlertInPickerChanges()
    }
}
