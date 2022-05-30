```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: How to update the content inside the ScrollView : SwiftUI (by Malav Soni)

A: Representable is updated whenever some binding of dependent data is updated, so you need to rebuild internals in update `updateUIView` when images changes.

Here is a solution. Tested with Xcode 11.4 / iOS 13.4

![Jsf3A](https://user-images.githubusercontent.com/62171579/170989628-5eee2e86-cf3f-4765-a2b8-f5e33c6ee8a1.gif)


Usage of representable

```
// images as binding
STHorizontalScrollView(images: self.$images, size: reader.size)
```

and representable itself

```
struct STHorizontalScrollView:UIViewRepresentable {
    @Binding var images:[String]
    var size:CGSize

    func makeUIView(context: Context) -> UIScrollView {
        UIScrollView()
    }

    func updateUIView(_ scrollView: UIScrollView, context: Context) {
        _ = scrollView.subviews.map { $0.removeFromSuperview() }
        guard images.count != 0 else { return }
        
        // Calculating the Width
        let widthForContent = CGFloat(self.images.count) * size.width
        scrollView.contentSize = CGSize.init(width: widthForContent, height: size.height)
        scrollView.isPagingEnabled = true

        // Hosting Controller
        let hostingController = UIHostingController(rootView: HorizontalList(images: images, size: size))
        hostingController.view.frame = CGRect.init(x: 0, y: 0, width: widthForContent, height: size.height)

        // Add View to scrollview
       scrollView.addSubview(hostingController.view)
    }
}
```
