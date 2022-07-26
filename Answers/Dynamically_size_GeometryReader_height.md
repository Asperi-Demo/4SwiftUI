```
BOYCOTT on ᵣussia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: Dynamically size a GeometryReader height based on it's elements (by Pasta)

A: Due to "hen-egg" problem in nature of `GeometryReader` the solution for topic question is possible only in run-time, because 
1) initial height is unknown 
2) it needs to calculate internal size based on all available external size 
3) it needs to tight external size to calculated internal size.

So here is possible approach (with some additional fixes in code)

![7O4vk](https://user-images.githubusercontent.com/62171579/164958261-a6845458-0394-4e8f-92d6-37a754b57158.png)
![DHyGq](https://user-images.githubusercontent.com/62171579/164958271-d9830227-8f30-40bd-8ce6-fdb11e949855.png)
![XA6E7](https://user-images.githubusercontent.com/62171579/164958274-164a8b1e-5b7f-4f57-b803-fb028c126f0d.png)


1) Preview 2-3) Run-time

Code:

```
struct ProblematicView: View {

    @State private var totalHeight = CGFloat(100) // no matter - just for static Preview !!
    @State private var tags: [String] = ["content", "content 2 ", "content 3", "content 4", "content 5"]

    var body: some View {
        var width = CGFloat.zero
        var height = CGFloat.zero

        return VStack {
            Text("Some reasonnably long text that changes dynamically do can be any size").background(Color.red)
            VStack { // << external container
                GeometryReader { g in
                    ZStack(alignment: .topLeading) { // internal container
                        ForEach(self.tags, id: \.self) { tag in
                            TagView(content: tag, color: .red, action: {
                                    // self.tags.removeLast()         // << just for testing
                                })
                                .padding([.horizontal, .vertical], 4)
                                .alignmentGuide(.leading, computeValue: { d in
                                    if (abs(width - d.width) > g.size.width)
                                    {
                                        width = 0
                                        height -= d.height
                                    }
                                    let result = width
                                    if tag == self.tags.last! {
                                        width = 0 //last item
                                    } else {
                                        width -= d.width
                                    }
                                    return result
                                })
                                .alignmentGuide(.top, computeValue: {d in
                                    let result = height
                                    if tag == self.tags.last! {
                                        height = 0 // last item
                                    }
                                    return result
                                })
                        }
                    }.background(Color.green)
                    .background(GeometryReader {gp -> Color in
                        DispatchQueue.main.async {
                            // update on next cycle with calculated height of ZStack !!!
                            self.totalHeight = gp.size.height
                        }
                        return Color.clear
                    })
                }.background(Color.blue)
            }.frame(height: totalHeight)
        }.background(Color.gray)
    }
}

struct TagView: View {
    let content: String
    let color: Color
    let action: (() -> Void)?

    var body: some View {
        HStack {
            Text(content).padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
            Button(action: action ?? {}) {
                Image(systemName: "xmark.circle").foregroundColor(Color.gray)
            }.padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 7))
        }
        .background(color)
        .cornerRadius(8.0)
    }
}
```
