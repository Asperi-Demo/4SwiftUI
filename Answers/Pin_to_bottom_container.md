>
> 🔥BOYCOTT on russia - terrorist must be punished!<br>
> «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
> 
> ATTENTION: This is a demo - use it as you wish. Reference is appriciated.<br>
> If you want to thank - buy me coffee: [Coffee for Asperi](https://secure.wayforpay.com/donate/asperi)
>

Q: Position view bottom without using a spacer (by Peter Warbo)

A: Experimenting with different approaches I finally end up with creating own custom container, which, having some known limitation, fulfils my needs completely. Hope it would be helpful for someone else.

Demo:

![AF2Dw](https://user-images.githubusercontent.com/62171579/181807482-404540a3-3421-4657-88ba-a6770f9ab97e.png)


Pros: ContentView & PinnedView are absolutely independent in layout on each other, automatically handle device orientation, and actually limitless in internal content

Cons: Due to used `GeometryReader` using `.infinity` at top-level content or pinned view result in crash due to "chicken-egg" problem.


Container code:

    struct ContainerWithPinnedBottomView<Content, Pinned>: View 
                                         where Content: View, Pinned: View {
    
        private var content: () -> Content
        private var bottomView: () -> Pinned
    
        @inlinable public init(@ViewBuilder pinnedView: @escaping () -> Pinned,
                                @ViewBuilder content: @escaping () -> Content) {
            self.content = content
            self.bottomView = pinnedView
        }
    
        var body: some View {
            ZStack(alignment: .bottom) {
                Rectangle().fill(Color.clear) // !! Extends ZStack to full screen
                GeometryReader { _ in
                    ZStack {
                        self.content()
                    }
                }
                self.bottomView()
                    .alignmentGuide(.bottom) { $0[.bottom] }
            }
        }
        
    }

Usage example (of demo screenshot)

    struct TestBottomView: View {
        var body: some View {
            ContainerWithPinnedBottomView(pinnedView: {
                HStack {
                    Spacer()
                    Text("Always Pinned to Bottom")
                        .padding()
        //                .frame(width: .infinity) // !! LIMITATION - don't use, cycling crash
                    Spacer()
                }
                .background(Color.blue)
            }) {
                NavigationView {
                    List (0 ..< 100, id: \.self) { i in
                        NavigationLink(destination: Text("Other")) {
                            Text("Row \(i)")
                        }
                    }
                    .navigationBarTitle("TitleBar")
                }
            }
        }
    }
