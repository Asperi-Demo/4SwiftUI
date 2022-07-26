```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: How to call PHPhotoLibrary presentLimitedLibraryPicker from SwiftUI? (by flainez)

A: Here is some demo approach. Prepared & tested with Xcode 12 / iOS 14.

```
struct TestPhotosView: View {

	@State var showLibraryPicker = false

	var body: some View {
		NavigationView {
			VStack {
				Button("Open Library Picker") { self.showLibraryPicker = true }
			}
			.navigationBarTitle("Test", displayMode: .inline)
			.navigationViewStyle(StackNavigationViewStyle())
			.background(Group {
				if self.showLibraryPicker {
					TestLimitedLibraryPicker(isPresented: $showLibraryPicker)
				}
			})
		}
	}
}


struct TestLimitedLibraryPicker: UIViewControllerRepresentable {
	@Binding var isPresented: Bool

	func makeUIViewController(context: Context) -> UIViewController {
		let controller = UIViewController()

		DispatchQueue.main.async {
			PHPhotoLibrary.requestAuthorization() { result in
				PHPhotoLibrary.shared().presentLimitedLibraryPicker(from: controller)
				context.coordinator.trackCompletion(in: controller)
			}
		}
		
		return controller
	}

	func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}

	func makeCoordinator() -> Coordinator {
		Coordinator(isPresented: $isPresented)
	}
	class Coordinator: NSObject {
		private var isPresented: Binding<Bool>
		init(isPresented: Binding<Bool>) {
			self.isPresented = isPresented
		}

		func trackCompletion(in controller: UIViewController) {
			DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self, weak controller] in
				if controller?.presentedViewController == nil {
					self?.isPresented.wrappedValue = false
				} else if let controller = controller {
					self?.trackCompletion(in: controller)
				}
			}
		}
	}
}
```
