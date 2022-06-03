Q: How can I remove macOS SwiftUI title options? (by code13de)

A: A possible approach is to filter created menu after launch. So create app delegate adapter and on did finish, do the following:

	func applicationDidFinishLaunching(_ notification: Notification) {
		guard let mainMenu = NSApp.mainMenu else { return }
		let newMenu = NSMenu()
		if let appMenu = mainMenu.items.first {
			mainMenu.removeItem(appMenu) // cannot be in both, so remove from previous
			newMenu.addItem(appMenu)
		}
		if let helpMenu = NSApp.mainMenu?.items.last {
			mainMenu.removeItem(helpMenu)
			newMenu.addItem(helpMenu)
		}
		NSApp.mainMenu = newMenu   // << here !!
	}

Tested with Xcode 13.4 / macOS 12.4
