```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: SwiftUI how to change state on keyUp macOS event? (by WatashiJ)

A: Here is a demo of possible approach. Tested with Xcode 11.4 / macOS 10.15.4

The idea is to join custom NSWindow, generating key events, with SwiftUI View via injected publisher to environment values. This gives possibility to listen/handle events at any level of view hierarchy.

Below is full module (AppDelegate.swift) code. Also see useful comments in code.

```
import Cocoa
import SwiftUI
import Combine

// Environment key to hold even publisher
struct WindowEventPublisherKey: EnvironmentKey {
    static let defaultValue: AnyPublisher<NSEvent, Never> = 
        Just(NSEvent()).eraseToAnyPublisher() // just default stub
}


// Environment value for keyPublisher access
extension EnvironmentValues {
    var keyPublisher: AnyPublisher<NSEvent, Never> {
        get { self[WindowEventPublisherKey.self] }
        set { self[WindowEventPublisherKey.self] = newValue }
    }
}

// Custom window holding publisher and sending events to it. In general 
// it can be any event, but for originated question we limit to keyUp events
class Window: NSWindow {
    private let publisher = PassthroughSubject<NSEvent, Never>() // private

    var keyEventPublisher: AnyPublisher<NSEvent, Never> { // public
        publisher.eraseToAnyPublisher()
    }

    override func keyUp(with event: NSEvent) {
        publisher.send(event)
    }
}

// Root demo view
struct DemoKeyPressedView: View {
    @Environment(\.keyPublisher) var keyPublisher // << access to publisher

    @State private var index: Int = 0
    var body: some View {
        Text("Demo \(index)")
            .onReceive(keyPublisher) { event in // << listen to events
                self.keyPressed(with: event)
            }
    }
    
    func keyPressed(with event: NSEvent) {
        self.index += 1
    }
}

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var window: Window!


    func applicationDidFinishLaunching(_ aNotification: Notification) {

        // Create the custom window
        window = Window(
            contentRect: NSRect(x: 0, y: 0, width: 480, height: 300),
            styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
            backing: .buffered, defer: false)
        window.center()
        window.setFrameAutosaveName("Main Window")

        // Create the SwiftUI view that provides the window contents.
        let contentView = DemoKeyPressedView()
            .frame(minWidth: 400, maxWidth: .infinity, maxHeight: .infinity)
            .environment(\.keyPublisher, window.keyEventPublisher) // inject publisher

        window.contentView = NSHostingView(rootView: contentView)
        window.makeKeyAndOrderFront(nil)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
}
```
