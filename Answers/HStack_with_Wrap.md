```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: SwiftUI HStack with Wrap (by Flolle)

A: Here is some approach of how this could be done using alignmentGuide(s). It is simplified to avoid many code post, but hope it is useful.

**Update:** There is also updated & improved variant of below solution in my answer for [SwiftUI HStack with wrap and dynamic height](HStack_with_wrap_dynamic_height.md)

This is the result:

![fs8Ey](https://user-images.githubusercontent.com/62171579/162756379-986512ca-f6b6-47c4-be87-c842e0c70f35.png)


And here is full demo code (orientation is supported automatically):


    import SwiftUI
    
    struct TestWrappedLayout: View {
        @State var platforms = ["Ninetendo", "XBox", "PlayStation", "PlayStation 2", "PlayStation 3", "PlayStation 4"]
    
        var body: some View {
            GeometryReader { geometry in
                self.generateContent(in: geometry)
            }
        }
    
        private func generateContent(in g: GeometryProxy) -> some View {
            var width = CGFloat.zero
            var height = CGFloat.zero
    
            return ZStack(alignment: .topLeading) {
                ForEach(self.platforms, id: \.self) { platform in
                    self.item(for: platform)
                        .padding([.horizontal, .vertical], 4)
                        .alignmentGuide(.leading, computeValue: { d in
                            if (abs(width - d.width) > g.size.width)
                            {
                                width = 0
                                height -= d.height
                            }
                            let result = width
                            if platform == self.platforms.last! {
                                width = 0 //last item
                            } else {
                                width -= d.width
                            }
                            return result
                        })
                        .alignmentGuide(.top, computeValue: {d in
                            let result = height
                            if platform == self.platforms.last! {
                                height = 0 // last item
                            }
                            return result
                        })
                }
            }
        }
    
        func item(for text: String) -> some View {
            Text(text)
                .padding(.all, 5)
                .font(.body)
                .background(Color.blue)
                .foregroundColor(Color.white)
                .cornerRadius(5)
        }
    }
    
    struct TestWrappedLayout_Previews: PreviewProvider {
        static var previews: some View {
            TestWrappedLayout()
        }
    }


