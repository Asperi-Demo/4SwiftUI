```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: SwiftUI: Pin to the top & bottom of a centered element (by Josh)

A: If I correctly understood your goal (because, as @nayem commented, at first time seems I missed), the following approach should be helpful.

![h5N2w](https://user-images.githubusercontent.com/62171579/173222385-642c1bff-4cc9-4314-8c18-a5f00aa4ffbb.png)

Code snapshot:

    extension VerticalAlignment {
       private enum CenteredMiddleView: AlignmentID {
          static func defaultValue(in dimensions: ViewDimensions) -> CGFloat {
             return dimensions[VerticalAlignment.center]
          }
       }
    
        static let centeredMiddleView = VerticalAlignment(CenteredMiddleView.self)
    }
    
    extension Alignment {
        static let centeredView = Alignment(horizontal: HorizontalAlignment.center, 
                              vertical: VerticalAlignment.centeredMiddleView)
    }
    
    struct TestHeaderFooter: View {
        var body: some View {
            ZStack(alignment: .centeredView) {
                Rectangle().fill(Color.clear) // !! Extends ZStack to full screen
                VStack {
                    Header()
                    Text("I'm on center")
                        .alignmentGuide(.centeredMiddleView) { 
                             $0[VerticalAlignment.center]
                        }
                    Footer()
                }
            }
    //        .edgesIgnoringSafeArea(.top) // uncomment if needed
        }
    }
    
    struct Header: View {
        var body: some View {
            Rectangle()
                .fill(Color.blue)
                .frame(height: 40)
        }
    }
    
    struct Footer: View {
        var body: some View {
            Rectangle()
                .fill(Color.green)
                .frame(height: 200)
        }
    }
    
