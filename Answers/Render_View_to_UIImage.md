```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: How do I render a SwiftUI View that is not at the root hierarchy as a UIImage? (by user12533955)

A: Here is the approach that works for me, as I needed to get image exactly sized as it is when placed alongside others. Hope it would be helpful for some else.

Demo: above divider is SwiftUI rendered, below is image (in border to show size)

![od9VR](https://user-images.githubusercontent.com/62171579/164229223-78b3e279-3c20-4aaa-bf39-c2ef664e535a.png)



    extension View {
        func asImage() -> UIImage {
            let controller = UIHostingController(rootView: self)
    
            // locate far out of screen
            controller.view.frame = CGRect(x: 0, y: CGFloat(Int.max), width: 1, height: 1)
            UIApplication.shared.windows.first!.rootViewController?.view.addSubview(controller.view)
    
            let size = controller.sizeThatFits(in: UIScreen.main.bounds.size)
            controller.view.bounds = CGRect(origin: .zero, size: size)
            controller.view.sizeToFit()
    
            let image = controller.view.asImage()
            controller.view.removeFromSuperview()
            return image
        }
    }
    
    extension UIView {
        func asImage() -> UIImage {
            let renderer = UIGraphicsImageRenderer(bounds: bounds)
            return renderer.image { rendererContext in
    // [!!] Uncomment to clip resulting image
    //             rendererContext.cgContext.addPath(
    //                UIBezierPath(roundedRect: bounds, cornerRadius: 20).cgPath)
    //            rendererContext.cgContext.clip()

    // As commented by @MaxIsom below in some cases might be needed
    // to make this asynchronously, so uncomment below DispatchQueue
    // if you'd same met crash
    //            DispatchQueue.main.async {
                     layer.render(in: rendererContext.cgContext)
    //            }
            }
        }
    }
    
    
    // TESTING
    struct TestableView: View {
        var body: some View {
            VStack {
                Text("Test 1")
                Text("Test 2")
            }
        }
    }
    
    struct TestBackgroundRendering: View {
        var body: some View {
            VStack {
                TestableView()
                Divider()
                Image(uiImage: render())
                    .border(Color.black)
            }
        }
        
        private func render() -> UIImage {
            TestableView().asImage()
        }
    }
    
