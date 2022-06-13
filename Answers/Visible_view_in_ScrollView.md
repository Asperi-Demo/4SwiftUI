Q: Get onAppear behaviour from list in ScrollView in SwiftUI (by M. Koot)

A: Here is possible approach how to do this (tested/worked with Xcode 11.2 / iOS 13.2)

Demo: (just show dynamically first & last visible cell in scrollview)

![qSBlw](https://user-images.githubusercontent.com/62171579/173405636-1e141576-1394-490d-bc72-998d1092db25.gif)


A couple of important `View` extensions
 
    extension View {
        func rectReader(_ binding: Binding<CGRect>, in space: CoordinateSpace) -> some View {
            self.background(GeometryReader { (geometry) -> AnyView in
                let rect = geometry.frame(in: space)
                DispatchQueue.main.async {
                    binding.wrappedValue = rect
                }
                return AnyView(Rectangle().fill(Color.clear))
            })
        }
    }
    
    extension View {
        func ifVisible(in rect: CGRect, in space: CoordinateSpace, execute: @escaping (CGRect) -> Void) -> some View {
            self.background(GeometryReader { (geometry) -> AnyView in
                let frame = geometry.frame(in: space)
                if frame.intersects(rect) {
                    execute(frame)
                }
                return AnyView(Rectangle().fill(Color.clear))
            })
        }
    }

And a demo view of how to use them with cell views being in scroll view
    
    struct TestScrollViewOnVisible: View {
        @State private var firstVisible: Int = 0
        @State private var lastVisible: Int = 0
        @State private var visibleRect: CGRect = .zero
        var body: some View {
            VStack {
                HStack {
                    Text("<< \(firstVisible)")
                    Spacer()
                    Text("\(lastVisible) >> ")
                }
                Divider()
                band()
            }
        }
        
        func band() -> some View {
            ScrollView(.horizontal) {
                HStack(spacing: 10) {
                    ForEach(0..<50) { i in
                        self.cell(for: i)
                            .ifVisible(in: self.visibleRect, in: .named("my")) { rect in
                                print(">> become visible [\(i)]")
                                
                                // do anything needed with visible rects, below is simple example
                                // (w/o taking into account spacing)
                                if rect.minX <= self.visibleRect.minX && self.firstVisible != i {
                                    DispatchQueue.main.async {
                                        self.firstVisible = i
                                    }
                                } else
                                if rect.maxX >= self.visibleRect.maxX && self.lastVisible != i {
                                    DispatchQueue.main.async {
                                        self.lastVisible = i
                                    }
                                }
                            }
                    }
                }
            }
            .coordinateSpace(name: "my")
            .rectReader(self.$visibleRect, in: .named("my"))
        }
    
        func cell(for idx: Int) -> some View {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.yellow)
                .frame(width: 80, height: 60)
                .overlay(Text("\(idx)"))
        }
    }
