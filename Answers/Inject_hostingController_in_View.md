```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: SwiftUI - How to access UIHostingController from SwiftUI (by Leo)

A: Here is a demo of possible approach - to use external configuration wrapper class to hold weak link to controller and inject it into SwiftUI view (as alternate it is also possible to make it `ObservableObject` to combine with other global properties and logic).

Tested with Xcode 12.5 / iOS 14.5

```
class Configuration {
	weak var hostingController: UIViewController?    // << wraps reference
}

struct SwiftUIView: View {
	let config: Configuration   // << reference here

	var body: some View {
		Button("Demo") {
			self.config.hostingController?.title = "New Title"
		}
	}
}

let configuration = ExtConfiguration()
let controller = UIHostingController(rootView: SwiftUIView(config: configuration))

// injects here, because `configuration` is a reference !!
configuration.hostingController = controller

controller.title = "title"
MyNavigationManager.present(controller)
```
