// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: 	By using this you agree do not repost any part of this code
//					on StackOverflow site. Thanks, Asperi.

import SwiftUI

@main
struct PlayOn_iOSApp: App {
	init() {
		if ProcessInfo.processInfo.environment["DISABLE_ANIMATIONS"] == "1" {
			UIView.setAnimationsEnabled(false)
		}
	}

	var body: some Scene {
		WindowGroup {
			// ❌ Try don't do here anything more than
			// just create a root view ‼️
			ContentView()
		}
	}

}
