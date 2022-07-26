```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: Support swipe to dismiss for UIViewControllerRepresentable presented in sheet (by Jordan H)

A: Possible solution is to add something like *handle* to drag (no styling - simplified for demo),

![RlGEg](https://user-images.githubusercontent.com/62171579/174424066-f1aac538-3dff-451f-8482-9ed093853475.png)


    .sheet(isPresented: $showingPicker, content: {
    		VStack {
    			RoundedRectangle(cornerRadius: 8).fill(Color.gray)
    				.frame(width: 60, height: 8)
    				.padding(.top, 8)
    			PHPicker()
    		}
    })


**Alternate:** the solution is to make presentation by UIKit completely and just pass activation binding inside representable.

Here is a demo of possible approach. Tested with Xcode 12.1 / iOS 14.1

![uFJe0](https://user-images.githubusercontent.com/62171579/174424071-5eded376-c9ea-4e2d-a1fe-710b71161605.gif)

```
struct PHPickerContentView: View {
    @State var showingPicker = false
    
    var body: some View {
        Button("Picker") {
           showingPicker = true
        }
        .background(PHPicker(isPresented: $showingPicker))    // << here !!
    }
}

struct PHPicker: UIViewControllerRepresentable {
	@Binding var isPresented: Bool

	func makeUIViewController(context: Context) -> UIViewController {
		UIViewController()   // << picker presenter
	}
	
	func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        // react on binding & show if not shown
		if isPresented && uiViewController.presentedViewController == nil {
			let config = PHPickerConfiguration()
			let picker = PHPickerViewController(configuration: config)
			picker.delegate = context.coordinator

			uiViewController.present(picker, animated: true)
			picker.presentationController?.delegate = context.coordinator
		}
	}
	
	func makeCoordinator() -> Coordinator {
		Coordinator(self)
	}
	
	class Coordinator: NSObject, PHPickerViewControllerDelegate, UIAdaptivePresentationControllerDelegate {
		let owner: PHPicker
		init(_ owner: PHPicker) {
			self.owner = owner
		}

		func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {

            // picked image handling code here
		
			picker.presentingViewController?.dismiss(animated: true)
			owner.isPresented = false    // << reset on action !!
		}
		
		func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
			owner.isPresented = false    // << reset on swipe !!
		}
	}
}
```
