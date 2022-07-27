// 🔥BOYCOTT on russia - terrorist must be punished!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI
import Combine

struct TestResetTimerInButton: View {

	@State private var timer: Publishers.Autoconnect<Timer.TimerPublisher>?
	@State private var value = 10
	var body: some View {
		Button {
			if timer != nil {
				timer = nil
				value = 10
			} else {
				timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
			}
		} label: {
			Text("Toggle")
		}
		if timer != nil {
			Text("Counter: \(value)").font(.largeTitle)
				.onReceive(timer!) { _ in
					value = value == 0 ? 10 : value - 1
				}
		}
	}
}

struct TestResetTimerInButton_Previews: PreviewProvider {
    static var previews: some View {
        TestResetTimerInButton()
    }
}
