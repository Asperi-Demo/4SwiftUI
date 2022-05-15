```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: SwiftUI Generic Pull to refresh view (by M1X)

A: Here is possible approach (compiled with Xcode 11.4)

Usage:

``` 
CustomScrollView(width: 100, height: 100, 
   viewModel: HomeViewMode()) {
      HomeView()
}
```

Generic type:

```
protocol CustomViewModel {
    func loadPackages()
}


// It is used generic ViewBuilder pattern for content 
struct CustomScrollView<Content: View, VM: CustomViewModel> : UIViewRepresentable {
    var width : CGFloat
    var height : CGFloat

    let viewModel: VM
    let content: () -> Content

    init(width: CGFloat, height: CGFloat, viewModel: VM, @ViewBuilder content: @escaping () -> Content) {
        self.width = width
        self.height = height
        self.viewModel = viewModel
        self.content = content
    }

    func makeUIView(context: Context) -> UIScrollView {
        let control = UIScrollView()
        control.refreshControl = UIRefreshControl()
        control.refreshControl?.addTarget(context.coordinator, action: #selector(Coordinator.handleRefreshControl), for: .valueChanged)

        let childView = UIHostingController(rootView: content())

        childView.view.frame = CGRect(x: 0, y: 0, width: width, height: height)

        control.addSubview(childView.view)
        return control
    }

    func updateUIView(_ uiView: UIScrollView, context: Context) { }

    class Coordinator: NSObject {
        var control: CustomScrollView<Content, VM>
        var viewModel: VM

        init(_ control: CustomScrollView, viewModel: VM) {
            self.control = control
            self.viewModel = viewModel
        }

        @objc func handleRefreshControl(sender: UIRefreshControl) {
            sender.endRefreshing()
            viewModel.loadPackages()
        }
    }
}
```
