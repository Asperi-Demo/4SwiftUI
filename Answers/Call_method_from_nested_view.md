```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: SwiftUI: calling a method from nested view (by Ugo Marinelli)

A: You can make your class ObservableObject and inject it as environment object, so any subview can use it and main view would be able to observe it.

Something like

```
class MyViewModel: ObservableObject {
	@Published var loading = false
	func fetchSomeData() {
		loading = true
		
		DispatchQueue.global(qos: .background).async {
			print("Fetching Some Data")
			// ... long activity here
			DispatchQueue.main.async { [weak self] in
				self?.loading = false
			}
		}
		
	}
}

struct MyMainView: View {
	
	@StateObject var myViewModel = MyViewModel()
	var body: some View {
		HeaderView().environmentObject(myViewModel)
		if myViewModel.loading {
			Text("Loading...")
		}
	}
}

struct HeaderView: View {
	
	var body: some View {
		HeaderSubview()
	}
}

struct HeaderSubview: View {
	@EnvironmentObject var viewModel: MyViewModel
	var body: some View {
		Button("Search") {
			// I want to call my View Model method here
			viewModel.fetchSomeData()
		}
	}
}
```
