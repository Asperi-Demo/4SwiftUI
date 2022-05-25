```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: Presenting UIDocumentInteractionController with UIViewControllerRepresentable in SwiftUI (by Simon)

A: Here is possible approach to integrate `UIDocumentInteractionController` for usage from SwiftUI view.

![YMAoD](https://user-images.githubusercontent.com/62171579/170184971-05de3f37-03d0-439e-9f0a-d5619313d4e0.gif)

Full-module code. Tested with Xcode 11.2 / iOS 13.2

    import SwiftUI
    import UIKit
    
    struct DocumentPreview: UIViewControllerRepresentable {
        private var isActive: Binding<Bool>
        private let viewController = UIViewController()
        private let docController: UIDocumentInteractionController
    
        init(_ isActive: Binding<Bool>, url: URL) {
            self.isActive = isActive
            self.docController = UIDocumentInteractionController(url: url)
        }
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<DocumentPreview>) -> UIViewController {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<DocumentPreview>) {
            if self.isActive.wrappedValue && docController.delegate == nil { // to not show twice
                docController.delegate = context.coordinator
                self.docController.presentPreview(animated: true)
            }
        }
        
        func makeCoordinator() -> Coordintor {
            return Coordintor(owner: self)
        }
        
        final class Coordintor: NSObject, UIDocumentInteractionControllerDelegate { // works as delegate
            let owner: DocumentPreview
            init(owner: DocumentPreview) {
                self.owner = owner
            }
            func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
                return owner.viewController
            }
            
            func documentInteractionControllerDidEndPreview(_ controller: UIDocumentInteractionController) {
                controller.delegate = nil // done, so unlink self
                owner.isActive.wrappedValue = false // notify external about done
            }
        }
    }
    
    // Demo of possible usage
    struct DemoPDFPreview: View {
        @State private var showPreview = false // state activating preview
    
        var body: some View {
            VStack {
                Button("Show Preview") { self.showPreview = true }
                    .background(DocumentPreview($showPreview, // no matter where it is, because no content
                                url: Bundle.main.url(forResource: "example", withExtension: "pdf")!))
            }
        }
    }
