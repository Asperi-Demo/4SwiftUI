```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: Center Item Inside Horizontal Stack (by Evan)

A: I would propose the following start point (simplest case... read below why)

![kvKGg](https://user-images.githubusercontent.com/62171579/170482612-bc188542-dafe-4339-8861-79d28b14f56e.png)

As it's seen it really gives centred w/o frame shift with correctly aligned side elements, but ... there is **drawback** - it will work in such simplest variant _only_ if it is known in advance that those _three text elements should never overlap_ in user run-time. If it is the case (really there are such) then this approach just goes. However if left/right text might grow in run-time, then more calculations will be needed to limit their width by `.frame(maxWidth:)` depending on the width of centred element... that variant is more complicated, but it is feasible.

    var body: some View {
            ZStack {
                HStack {
                    Text("Longer side")
                    Spacer()
                    Text("One")
                }
                item2()
            }
        }
    
    private func item2() -> some View {
        Text("CENTER")
            .background(Color.yellow)
            .border(Color.red)
    }


**Update:** here is possible approach to limit one of the side to not overlap centred one (contains async updates, so should be tested in _Live Preview_ or Simulator)

So... if left text is dynamic and the requirement to cut trailing symbols, here is how it could go ...

![kkBeB](https://user-images.githubusercontent.com/62171579/170482647-c98708c7-f427-4937-804d-372457b03cc1.png)


and it automatically fit well on device orientation change

![HzTRa](https://user-images.githubusercontent.com/62171579/170482683-25a3ae18-987e-4080-bdca-1468bd7068e4.png)



    struct TestHorizontalPinCenter: View {
    
        @State var centerFrame: CGRect = .zero
        
        private let kSpacing: CGFloat = 4.0
        var body: some View {
                ZStack {
                    HStack {
                        Text("Longer side very long text to fit")
                            .lineLimit(1)
                            .frame(maxWidth: (centerFrame == .zero ? .infinity : centerFrame.minX - kSpacing), alignment: .leading)
    
                        Spacer()
                        
                        Text("One")
                    }
                    item2()
                        .background(rectReader($centerFrame))
                }
            }
        
        private func item2() -> some View {
            Text("CENTER")
                .background(Color.yellow)
                .border(Color.red)
        }
    
        func rectReader(_ binding: Binding<CGRect>) -> some View {
            return GeometryReader { (geometry) -> AnyView in
                let rect = geometry.frame(in: .global)
                DispatchQueue.main.async {
                    binding.wrappedValue = rect
                }
                return AnyView(Rectangle().fill(Color.clear))
            }
        }
    }
    

And if it is needed to wrap left side, then `.lineLimit(nil)` and additional layout will be needed, and solution growth, but the idea is the same. Hope this will be helpful for someone.
