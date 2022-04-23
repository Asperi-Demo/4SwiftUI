```
BOYCOTT on ᵣussia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: How to make a SwiftUI List scroll automatically? (by )

A: As there is no built-in such feature for now (neither for List nor for ScrollView), Xcode 11.2, so I needed to code custom ScrollView with ScrollToEnd behaviour

**!!! Inspired by [this][1] article.**

Here is a result of my experiments, hope one finds it helpful as well. Of course there are more parameters, which might be configurable, like colors, etc., but it appears trivial and out of scope.

![fVJay](https://user-images.githubusercontent.com/62171579/163183740-b6696387-d7fe-41b7-9bc1-ea53784daea8.gif)
![xgaVy](https://user-images.githubusercontent.com/62171579/163183813-6ba8c188-4bea-4d8c-868d-0ba7fd5022f4.gif)


  [1]: https://blog.process-one.net/writing-a-custom-scroll-view-with-swiftui-in-a-chat-application/


    import SwiftUI
    
    struct ContentView: View {
        @State private var objects = ["0", "1"]
    
        var body: some View {
            NavigationView {
                VStack {
                    CustomScrollView(scrollToEnd: true) {
                        ForEach(self.objects, id: \.self) { object in
                            VStack {
                                Text("Row \(object)").padding().background(Color.yellow)
                                NavigationLink(destination: Text("Details for \(object)")) {
                                    Text("Link")
                                }
                                Divider()
                            }.overlay(RoundedRectangle(cornerRadius: 8).stroke())
                        }
                    }
                    .navigationBarTitle("ScrollToEnd", displayMode: .inline)
    
    //                CustomScrollView(reversed: true) {
    //                    ForEach(self.objects, id: \.self) { object in
    //                        VStack {
    //                            Text("Row \(object)").padding().background(Color.yellow)
    //                            NavigationLink(destination: Text("Details for \(object)")) {
    //                                Image(systemName: "chevron.right.circle")
    //                            }
    //                            Divider()
    //                        }.overlay(RoundedRectangle(cornerRadius: 8).stroke())
    //                    }
    //                }
    //                .navigationBarTitle("Reverse", displayMode: .inline)
    
                    HStack {
                        Button(action: {
                            self.objects.append("\(self.objects.count)")
                        }) {
                            Text("Add")
                        }
                        Button(action: {
                            if !self.objects.isEmpty {
                                self.objects.removeLast()
                            }
                        }) {
                            Text("Remove")
                        }
                    }
                }
            }
        }
    }
    
    struct CustomScrollView<Content>: View where Content: View {
        var axes: Axis.Set = .vertical
        var reversed: Bool = false
        var scrollToEnd: Bool = false
        var content: () -> Content
    
        @State private var contentHeight: CGFloat = .zero
        @State private var contentOffset: CGFloat = .zero
        @State private var scrollOffset: CGFloat = .zero
    
        var body: some View {
            GeometryReader { geometry in
                if self.axes == .vertical {
                    self.vertical(geometry: geometry)
                } else {
                    // implement same for horizontal orientation
                }
            }
            .clipped()
        }
    
        private func vertical(geometry: GeometryProxy) -> some View {
            VStack {
                content()
            }
            .modifier(ViewHeightKey())
            .onPreferenceChange(ViewHeightKey.self) {
                self.updateHeight(with: $0, outerHeight: geometry.size.height)
            }
            .frame(height: geometry.size.height, alignment: (reversed ? .bottom : .top))
            .offset(y: contentOffset + scrollOffset)
            .animation(.easeInOut)
            .background(Color.white)
            .gesture(DragGesture()
                .onChanged { self.onDragChanged($0) }
                .onEnded { self.onDragEnded($0, outerHeight: geometry.size.height) }
            )
        }
    
        private func onDragChanged(_ value: DragGesture.Value) {
            self.scrollOffset = value.location.y - value.startLocation.y
        }
    
        private func onDragEnded(_ value: DragGesture.Value, outerHeight: CGFloat) {
            let scrollOffset = value.predictedEndLocation.y - value.startLocation.y
    
            self.updateOffset(with: scrollOffset, outerHeight: outerHeight)
            self.scrollOffset = 0
        }
    
        private func updateHeight(with height: CGFloat, outerHeight: CGFloat) {
            let delta = self.contentHeight - height
            self.contentHeight = height
            if scrollToEnd {
                self.contentOffset = self.reversed ? height - outerHeight - delta : outerHeight - height
            }
            if abs(self.contentOffset) > .zero {
                self.updateOffset(with: delta, outerHeight: outerHeight)
            }
        }
    
        private func updateOffset(with delta: CGFloat, outerHeight: CGFloat) {
            let topLimit = self.contentHeight - outerHeight
    
            if topLimit < .zero {
                 self.contentOffset = .zero
            } else {
                var proposedOffset = self.contentOffset + delta
                if (self.reversed ? proposedOffset : -proposedOffset) < .zero {
                    proposedOffset = 0
                } else if (self.reversed ? proposedOffset : -proposedOffset) > topLimit {
                    proposedOffset = (self.reversed ? topLimit : -topLimit)
                }
                self.contentOffset = proposedOffset
            }
        }
    }
    
    struct ViewHeightKey: PreferenceKey {
        static var defaultValue: CGFloat { 0 }
        static func reduce(value: inout Value, nextValue: () -> Value) {
            value = value + nextValue()
        }
    }
    
    extension ViewHeightKey: ViewModifier {
        func body(content: Content) -> some View {
            return content.background(GeometryReader { proxy in
                Color.clear.preference(key: Self.self, value: proxy.size.height)
            })
        }
    }

