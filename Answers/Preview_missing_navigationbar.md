```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: QLPreviewController missing navigation bar in SwiftUI (by Hüseyin)

A: QuickLook preview does not have own navigation controller, it is our responsibility to provided one.

Here is possible approach. Tested with Xcode 11.4 / iOS 13.4

![PPX10](https://user-images.githubusercontent.com/62171579/167244695-a25315f1-606e-4999-9c21-af3914230837.gif)

```
struct TestQLPreviewController: View {
  @State private var showQuickLook = false

  // just for demo - document.pdf is located in main bundle
  @State private var selectedURL = Bundle.main.url(forResource: "document", withExtension: "pdf")
  var body: some View {
    Button("Show") { self.showQuickLook.toggle() }
      .sheet(isPresented: $showQuickLook, onDismiss: {self.showQuickLook = false}) {
                  if  self.selectedURL != nil {
                    QuickLookController(url: self.selectedURL!) {
                      self.showQuickLook = false
                    }
                  }
                }
  }
}


struct QuickLookController: UIViewControllerRepresentable {

  var url: URL
  var onDismiss: () -> Void

  func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }

  func updateUIViewController(_ viewController: UINavigationController, context: UIViewControllerRepresentableContext<QuickLookController>) {
    if let controller = viewController.topViewController as? QLPreviewController {
      controller.reloadData()
    }
  }

  func makeUIViewController(context: Context) -> UINavigationController {
    let controller = QLPreviewController()

    controller.dataSource = context.coordinator
    controller.reloadData()
    return UINavigationController(rootViewController: controller)
  }

  class Coordinator: NSObject, QLPreviewControllerDataSource {
    var parent: QuickLookController

    init(_ qlPreviewController: QuickLookController) {
      self.parent = qlPreviewController
      super.init()
    }
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
      return 1
    }
    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
      return self.parent.url as QLPreviewItem
    }

  }
}
```
