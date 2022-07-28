>
> 🔥BOYCOTT on russia - terrorist must be punished!<br>
> «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
> 
> ATTENTION: This is a demo - use it as you wish. Reference is appriciated.<br>
> If you want to thank - buy me coffee: [Coffee for Asperi](https://secure.wayforpay.com/donate/asperi)
>

Q: SwiftUI/macOS: DatePicker without background field (by ChrisR)

A: Here is a simplified demo of representable wrapper approach

Tested with Xcode 13.2 / macOS 12.1

![ivzWv](https://user-images.githubusercontent.com/62171579/181459504-5d469159-3d4e-4844-a2c1-9a2fb0637cca.png)

```
struct DemoView: View {
    @State private var newDate: Date = Date()

    var body: some View {
    	VStack {
     		Text("Selected: \(newDate)")
        	MyDatePicker(selection: $newDate)
        }
    }
}

struct MyDatePicker: NSViewRepresentable {
	@Binding var selection: Date

    func makeNSView(context: Context) -> NSDatePicker {
        let picker = NSDatePicker()
        picker.isBordered = false
        picker.datePickerStyle = .textField
		picker.action = #selector(Coordinator.onValueChange(_:))
  		picker.target = context.coordinator
        return picker
    }

    func updateNSView(_ picker: NSDatePicker, context: Context) {
    	picker.dateValue = selection
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(owner: self)
    }

    class Coordinator: NSObject {
    	private let owner: MyDatePicker
    	init(owner: MyDatePicker) {
			self.owner = owner
        }

        @objc func onValueChange(_ sender: Any?) {
        	if let picker = sender as? NSDatePicker {
				owner.selection = picker.dateValue
            }
        }
    }
}
```
