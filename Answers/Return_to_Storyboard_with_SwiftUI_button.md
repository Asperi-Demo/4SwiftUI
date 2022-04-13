```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: Return from SwiftUI to Storyboard with a SwiftUI button (by gnielio)

A: The unwind segue needs to be called from a view controller, so we
need to transfer somehow control from a SwiftUI view back to UIViewController
so it could perform unwind segue.

The idea is to use view model class a bridge that holds closure to be specified
by a view controller and called from a SwiftUI view button from injected view model.

Here is a demo. Prepared with XCode 13.3

```
struct SecondView: View {
	class ViewModel {
		var unwind: () -> ()  // unwind action
		init(_ unwind: @escaping () -> () = {}) {
			self.unwind = unwind
		}
	}

	var vm: ViewModel      // reference to view model
	var body: some View {
		Button(action: {
			vm.unwind()           // << here !!
		}) {
			Image("TopLeft")
				.renderingMode(.original)
				.resizable()
				.scaledToFit()
				.frame(width: 15, height: 15)
		}
	}
}

class ChildHostingController: UIHostingController<SecondView> {

	required init?(coder: NSCoder) {
		let viewModel = SecondView.ViewModel()
		super.init(coder: coder, rootView: SecondView(vm: viewModel))
		viewModel.unwind = { [weak self] in
		   // call unwind segue created in storyboard
			self?.performSegue(withIdentifier: "unwind_segue_identifier", sender: self)
		}
	}

	override func viewDidLoad() {
		super.viewDidLoad()
	}
}
```

[Just in case about creating unwind segue](https://medium.com/@ldeme/unwind-segues-in-swift-5-e392134c65fd)
