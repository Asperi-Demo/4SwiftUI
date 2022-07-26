// 🔥BOYCOTT on russia - terrorist must be punished!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestHypocycloidAnimation: View {
    @State var isAnimating: Bool = false
    
    let animation1 = Animation.linear(duration: 10).repeatForever(autoreverses: false)
    let animation2 = Animation.linear(duration: 5).repeatForever(autoreverses: false)
    let animation3 = Animation.linear(duration: 0.5).repeatForever(autoreverses: false)
    
    var body: some View {
        VStack {
            ZStack{
                Circle()
                    .stroke(style: .init(lineWidth: 1, lineCap: .round, lineJoin: .round))
                    .fill(Color(.blue))
                    .frame(width: 200, height: 200)
                    .padding()
                
                ZStack {
                    Circle()
                        .stroke(style: .init(lineWidth: 1, lineCap: .round, lineJoin: .round))
                        .fill(Color(.red))
                        .frame(width: 100, height: 100)
                        .overlay(
                            Rectangle()
                                .stroke(style: .init(lineWidth: 1, lineCap: .round, lineJoin: .round))
                                .fill(Color(.orange))
                                .frame(width: 1, height: 50)
                                .offset(x: 0, y: -25)
                                .rotationEffect(Angle(degrees: isAnimating ? 360 : 0))
                                .animation(isAnimating ? animation2 : .default, value: isAnimating)
                        )
                        .offset(x: 0, y: -50)
                        .rotationEffect(Angle(degrees: isAnimating ? 360.0 : 0), anchor: .center)
                        .animation(isAnimating ? animation1 : .default, value: isAnimating)
                    
                    Circle()
                        .fill(.white)
                        .frame(width: 10, height: 10)
                        .offset(x: 0, y: -100)
                        .rotationEffect(Angle(degrees: isAnimating ? 360.0 : 0), anchor: .center)
                        .animation(isAnimating ? animation3 : .default, value: isAnimating)
                }
            }
            
            .padding()
            Button {
                isAnimating.toggle()
            } label: {
                Text("Start/Stop")
            }
        }
    }
}

struct TestHypocycloidAnimation_Previews: PreviewProvider {
    static var previews: some View {
        TestHypocycloidAnimation()
    }
}
