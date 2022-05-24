// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: 	By using this you agree do not repost any part of this code
//					on StackOverflow site. Thanks, Asperi.

import SwiftUI

@main
struct PlayOn_macOSApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            ContentView()
            	.frame(width: 640, height: 480)
        }
        .handlesExternalEvents(matching: [])
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
	func application(_ application: NSApplication, open urls: [URL]) {
		print("Unhandled: \(urls)")
	}
	
	func applicationDidBecomeActive(_ notification: Notification) {
		// Restore first minimized window if app became active and no one window
		// is visible
		if NSApp.windows.compactMap({ $0.isVisible ? Optional(true) : nil }).isEmpty {
			 NSApp.windows.first?.makeKeyAndOrderFront(self)
		}
	}
}
