```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: How do you share a data model between a UIKit view controller and a SwiftUI view that it presents? (by Austin Conlon)

A: Let's analyse...

> My data model property is declared in my table view controller and the SwiftUI view is modally presented.

So here is what you have now (probably simplified)

```
struct DataModel {
   var value: String
}

class ViewController: UIViewController {
    var dataModel: DataModel

    // ... some other code

    func showForm() {
       let formView = FormView()
       let controller = UIHostingController(rootView: formView)
       self.present(controller, animating: true)
    }
}
```

> I'd like the presented Form input to manipulate the data model.

And here an update above with simple demo of passing value type data into SwiftUI view and get it back updated/modified/processed without any required refactoring of UIKit part.

The idea is simple - you pass current model into SwiftUI by value and return it back in completion callback updated and apply to local property (so if any observers are set they all work as expected)

Tested with Xcode 12 / iOS 14.

```
class ViewController: UIViewController {
	var dataModel: DataModel

	// ... some other code

	func showForm() {
		let formView = FormView(data: self.dataModel) { [weak self] newData in
   			    self?.dismiss(animated: true) {
				self?.dataModel = newData
			}
		}

		let controller = UIHostingController(rootView: formView)
		self.present(controller, animated: true)
	}
}

struct FormView: View {
	@State private var data: DataModel
	private var completion: (DataModel) -> Void

	init(data: DataModel, completion: @escaping (DataModel) -> Void) {
		self._data = State(initialValue: data)
		self.completion = completion
	}

	var body: some View {
		Form {
			TextField("", text: $data.value)
			Button("Done") {
				completion(data)
			}
		}
	}
}
```
