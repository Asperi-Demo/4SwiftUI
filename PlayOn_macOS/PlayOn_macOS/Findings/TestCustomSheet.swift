// 🔥BOYCOTT on russia - terrorist must be punished!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestCustomSheet: View {

    @State private var show: Bool = false
    var body: some View {
            Color.gray
                .overlay(VStack {
                    Button("show sheet") { show.toggle() }
                    Button("show window") {
                    	if let parent = NSApp.mainWindow {
                    		let window = sheetView().openInWindow(sender: nil)
							parent.addChildWindow(window, ordered: .above)

							var frame = parent.frame
							let (midX, maxY) = (frame.midX, frame.maxY)
							frame.size = window.frame.size
							frame.origin = NSPoint(x: midX - frame.size.width/2, y: maxY - frame.size.height / 2.0)
							window.setFrame(frame, display: true, animate: false)

					        window.makeKeyAndOrderFront(nil)
							frame.size = window.frame.size
							frame.origin = NSPoint(x: midX - frame.size.width/2, y: maxY - frame.size.height - 28)
							window.setFrame(frame, display: true, animate: true)
						}
					}
                })
                .frame(width: 200, height: 200)
                .sheet(isPresented: $show, content: { sheetView() })

    }
    func sheetView() -> some View {
        return Color.yellow
            .frame(width: 400, height: 400)
    }
}

extension View {
    @discardableResult
    func openInWindow(sender: Any?) -> NSWindow {
        let controller = NSHostingController(rootView: self)
        let window = NSWindow(contentViewController: controller)
        window.contentViewController = controller
        window.titleVisibility = .hidden
        window.toolbar = nil
        window.styleMask = .fullSizeContentView
        return window
    }
}

struct TestCustomSheet_Previews: PreviewProvider {
    static var previews: some View {
        TestCustomSheet()
    }
}
