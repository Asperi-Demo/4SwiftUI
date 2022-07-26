// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

@main
struct PlayOn_macOSApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            ContentView().frame(minWidth: 200, minHeight: 100)
        }
		 // needed because WindowGroup scene seems have default
		 // handler for external events, so opens new scene even
		 // if no onOpenURL or userActivity callbacks are present
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
