```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: How can I vertically align an image to the center of the first line of some text? (by DanubePM)

A: Here is a solution based on custom alignment. Tested with Xcode 11.4 / iOS 13.4

![8iXC3](https://user-images.githubusercontent.com/62171579/170961398-5d7a8b91-997c-43a4-a702-731e4a2052fa.png)

```
extension VerticalAlignment {
    private enum XAlignment : AlignmentID {
        static func defaultValue(in d: ViewDimensions) -> CGFloat {
            return d[VerticalAlignment.top]
        }
    }
    static let xAlignment = VerticalAlignment(XAlignment.self)
}

struct DemoAlignFirstLine: View {

    var body: some View {
        HStack(alignment: .xAlignment) {
            Image(systemName: "circle.fill")
                .font(.system(size: 8))
                .alignmentGuide(.xAlignment) { $0.height / 2.0 }

            ZStack(alignment: .topLeading) {
                // invisible anchor, should be of same font as text
                Text("X").foregroundColor(.clear)  
                    .alignmentGuide(.xAlignment) { $0.height / 2.0 }

                // main text
                Text("This is really really really really really really really really really really really really really really really really really really really really really really really really long string.")
            }
        }
    }
}
```
