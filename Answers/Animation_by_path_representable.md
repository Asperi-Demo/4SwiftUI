>
> 🔥BOYCOTT on russia - terrorist must be punished!<br>
> «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
> 
> ATTENTION: This is a demo - use it as you wish. Reference is appriciated.<br>
> If you want to thank - buy me coffee: [Coffee for Asperi](https://secure.wayforpay.com/donate/asperi)
>

Q: Is it possible to animate view on a certain Path in SwiftUI (by AntonijoDev)

A: Here is a demo of possible approach (just a sketch: many parameters just hardcoded, but they could be configured via properties, constructor, callbacks, etc.)

![wFHEw](https://user-images.githubusercontent.com/62171579/182015683-42d63ceb-332a-4959-a145-5e994c284ef8.gif)


    struct PathAnimatingView<Content>: UIViewRepresentable where Content: View {
        let path: Path
        let content: () -> Content
    
        func makeUIView(context: UIViewRepresentableContext<PathAnimatingView>) -> UIView {
            let view = UIView(frame: .zero)
            view.translatesAutoresizingMaskIntoConstraints = false
            view.layer.borderColor = UIColor.red.cgColor
            view.layer.borderWidth = 2.0
    
            let animation = CAKeyframeAnimation(keyPath: #keyPath(CALayer.position))
                animation.duration = CFTimeInterval(3)
                animation.repeatCount = 3
                animation.path = path.cgPath
                animation.isRemovedOnCompletion = false
                animation.fillMode = .forwards
                animation.timingFunction = CAMediaTimingFunction(name: .linear)
    
            let sub = UIHostingController(rootView: content())
            sub.view.translatesAutoresizingMaskIntoConstraints = false
    
            view.addSubview(sub.view)
            sub.view.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
            sub.view.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    
            view.layer.add(animation, forKey: "someAnimationName")
            return view
        }
    
        func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<PathAnimatingView>) {
        }
    
        typealias UIViewType = UIView
    }
    
    struct TestAnimationByPath: View {
        var body: some View {
            VStack {
                PathAnimatingView(path: Circle().path(in: 
                                  CGRect(x: 100, y: 100, width: 100, height: 100))) {
                    Text("Hello, World!")
                }
            }
        }
    }

