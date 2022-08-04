>
> 🔥BOYCOTT on russia - terrorist must be punished!<br>
> «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
> 
> ATTENTION: This is a demo - use it as you wish. Reference is appriciated.<br>
> If you want to thank - buy me coffee: [Coffee for Asperi](https://secure.wayforpay.com/donate/asperi)
>

Q: SwiftUI ternary conditional bug?

A: Not sure where is the problem, but the following test code works here. Tested with Xcode 11.2 / iOS 13.2.

![awRlU](https://user-images.githubusercontent.com/62171579/182870861-9531bf41-6246-4342-ad59-34645c5a2da2.gif)

    struct ContentView: View {
        @State private var selectedIdx: Int?
        var colors : [Color] = [.red, .orange, .yellow, .green, .blue]
    
        var body: some View {
            VStack {
                //some other views that change "selectedIdx" (the @State var)
                Button("Reset") { self.selectedIdx = nil }
                //...
                ForEach(0..<colors.count) { idx in
                    self.row(index: idx)
                        //some other view modifiers that will be animated
                        .animation(Animation.easeInOut.delay(self.selectedIdx == nil ? 0.1*Double(self.colors.count - idx) : 0.1*Double(idx)))
                        .onTapGesture { self.selectedIdx = idx }
                }
            }
        }
    
        func row(index: Int) -> some View {
            Rectangle()
                .fill(self.selectedIdx == index ? self.colors[index] : Color.black)
                .frame(width: 70, height: 100)
        }
    }

