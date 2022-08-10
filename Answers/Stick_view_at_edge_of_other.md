>
> 🔥BOYCOTT on russia - terrorist must be punished!<br>
> «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
> 
> ATTENTION: This is a demo - use it as you wish. Reference is appriciated.<br>
> If you want to thank - buy me coffee: [Coffee for Asperi](https://secure.wayforpay.com/donate/asperi)
>

Q: How can I align a progress indicator to the right of a label and keep the label centred in a VStack in SwiftUI? (by Duncan Groenewald)

A: Here is possible approach (tested replacing ActivityIndicator with just circle). 

Used Xcode 11.4 / iOS 13.4 / macOS 10.15.4

![8DzSC](https://user-images.githubusercontent.com/62171579/183807237-61fc67a2-8999-495a-adf4-517e9ebe9816.png)
![aVR8A](https://user-images.githubusercontent.com/62171579/183807255-dd9e10b1-d7a4-46c6-be2a-78858c5e49e8.png)

    var body: some View {
        VStack {
            HStack {
                Text("Some text")
                    .alignmentGuide(.hAlignment) { $0.width / 2.0 }
                ActivityIndicator()
            }
        }
        .frame(width: 200, height: 200, alignment: 
               Alignment(horizontal: .hAlignment, vertical: VerticalAlignment.center))
        .background(Color.pink)
    }

    extension HorizontalAlignment {
        private enum HAlignment : AlignmentID {
            static func defaultValue(in d: ViewDimensions) -> CGFloat {
                return d[HorizontalAlignment.center]
            }
        }
    
        static let hAlignment = HorizontalAlignment(HAlignment.self)
    }
