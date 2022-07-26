```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: run when a view redraws in SwiftUI (by Brian.Masse)

A: If I correctly understood your needs then you should do this not in view but in view model, like

```
class ViewModel: ObservableObject {
	var onModelChanged: (_ old: Model, _ new: Model) -> Void
	@Published var model = Model() {
		didSet {
			onModelChanged(oldValue, model)
		}
	}

	init(onModelChanged: @escaping (_ old: Model, _ new: Model) -> Void = {_, _ in}) {
		self.onModelChanged = onModelChanged
	}
}
```

so instantiating `ViewModel` you can provide a callback to observe values changed in model and have old and new values, like

```
@StateObject var viewModel = ViewModel() {
	print("Old value: \($0.someValue)")
	print("New value: \($1.someValue)")
}
```
