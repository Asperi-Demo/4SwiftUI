```
🔥BOYCOTT on russia - terrorist must be punished!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: How to show NSPopover in SwiftUI lifecycle? (by Roman Banks)

A: Here is a simple demo of possible approach - wrap control over native `NSPopover` into background view representable.

*Note: next wrapping of background into view modifier or/and making it more configurable is up to you.*

Prepared & tested with Xcode 13 / macOS 11.5.1

![5w08L](https://user-images.githubusercontent.com/62171579/176607449-c4d4a37b-303e-4c84-baef-06606f242030.gif)

```
struct ContentView: View {
	@State private var isVisible = false
	var body: some View {
		Button("Test") {
			isVisible.toggle()
		}
		.background(NSPopoverHolderView(isVisible: $isVisible) {
			Text("I'm in NSPopover")
				.padding()
		})
	}
}

struct NSPopoverHolderView<T: View>: NSViewRepresentable {
	@Binding var isVisible: Bool
	var content: () -> T

	func makeNSView(context: Context) -> NSView {
		NSView()
	}

	func updateNSView(_ nsView: NSView, context: Context) {
		context.coordinator.setVisible(isVisible, in: nsView)
	}

	func makeCoordinator() -> Coordinator {
		Coordinator(state: _isVisible, content: content)
	}

	class Coordinator: NSObject, NSPopoverDelegate {
		private let popover: NSPopover
		private let state: Binding<Bool>

		init<V: View>(state: Binding<Bool>, content: @escaping () -> V) {
			self.popover = NSPopover()
			self.state = state

			super.init()

			popover.delegate = self
			popover.contentViewController = NSHostingController(rootView: content())
			popover.behavior = .transient
		}

		func setVisible(_ isVisible: Bool, in view: NSView) {
			if isVisible {
				popover.show(relativeTo: view.bounds, of: view, preferredEdge: .minY)
			} else {
				popover.close()
			}
		}

		func popoverDidClose(_ notification: Notification) {
			self.state.wrappedValue = false
		}

		func popoverShouldDetach(_ popover: NSPopover) -> Bool {
			true
		}
	}
}
```
