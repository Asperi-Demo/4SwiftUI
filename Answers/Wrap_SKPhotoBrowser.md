Q: How to wrap SKPhotoBrowser?

A: The `SKPhotoBrowser` is a `UIViewController` subclass, so we need to conform it 
  to `UIViewControllerRepresentable` not `UIViewRepresentable`, and handle delegate callbacks
  in coordinator.

Actually, not much differences:

```swift
struct PhotoViewer: UIViewControllerRepresentable {

    @Binding var viewerImages:[SKPhoto]
    @Binding var currentPageIndex: Int

    func makeUIViewController(context: Context) -> SKPhotoBrowser {
        let browser = SKPhotoBrowser(photos: viewerImages)
        browser.initializePageIndex(currentPageIndex)
        browser.delegate = context.coordinator
        return browser
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func updateUIViewController(_ browser: SKPhotoBrowser, context: Context) {
        browser.photos = viewerImages
        browser.currentPageIndex = currentPageIndex
    }

    class Coordinator: NSObject, SKPhotoBrowserDelegate {

        var control: PhotoViewer

        init(_ control: PhotoViewer) {
            self.control = control
        }

        func didShowPhotoAtIndex(_ browser: PhotoViewer) {
            self.control.currentPageIndex = browser.currentPageIndex
        }

    }
}
```
