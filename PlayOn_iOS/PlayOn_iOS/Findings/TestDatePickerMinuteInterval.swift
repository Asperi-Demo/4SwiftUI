// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestDatePickerMinuteInterval: View {
	var body: some View {
		ContentView()
	}

	struct ContentView: View {
		@State private var selectedDate = Date()
		
		init() {
			UIDatePicker.appearance().minuteInterval = 15
		}
		
		var body: some View {
			DatePicker(
				"",
				selection: $selectedDate,
				/*in: ...Date(),*/
				displayedComponents: .hourAndMinute
			)
			.environment(\.locale, .init(identifier: "us"))
			
		}
	}
	
}

struct TestDatePickerMinuteInterval_Previews: PreviewProvider {
	static var previews: some View {
		TestDatePickerMinuteInterval()
	}
}
