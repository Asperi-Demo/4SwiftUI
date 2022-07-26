// 🔥BOYCOTT on russia - terrorist must be punished!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestGradientBorder: View {
    var specialRadialGradient: some View {
        GeometryReader { geometry in
            RadialGradient(
                gradient: Gradient(
                    stops: [
                        .init(color: Color.yellow.opacity(0.5), location: 0),
                        .init(color: Color.blue.opacity(0.5), location: 1)
                    ]
                ),
                center: .init(x: 0.1432, y: 0.7254),
                startRadius: .zero,
                endRadius: geometry.size.width * 0.75
            )
            .background(Color.green)
        }
    }
    
    var body: some View {
        ZStack {
//            Color.red   // uncomment to test transparency
            let borderWidth = 2.0
            Text("STOP russia NOW").foregroundColor(.red)
                .frame(maxWidth: .infinity)
                .padding()
                .background(
                    specialRadialGradient
                        .overlay(Rectangle().padding(borderWidth)    // << here !!
                            .blendMode(.destinationOut))
                        .compositingGroup()
                )
        }
    }
}

struct TestGradientBorder_Previews: PreviewProvider {
    static var previews: some View {
        TestGradientBorder()
    }
}
