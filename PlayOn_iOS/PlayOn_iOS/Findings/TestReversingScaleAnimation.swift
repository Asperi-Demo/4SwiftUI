// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestReversingScaleAnimation: View {

    @State var scaleImage : CGFloat = 1

    var body: some View {
        VStack {
            Button("Start animation") {
                self.scaleImage = 0.01       // initiate animation
            }

            Image(systemName: "circle.fill")
                .modifier(ReversingScale(to: scaleImage) {
                    self.scaleImage = 1      // reverse set
                })
                .animation(.default, value: scaleImage)         // now can be implicit
        }
    }
}

struct ReversingScale: AnimatableModifier {
    var value: CGFloat

    private let target: CGFloat
    private let onEnded: () -> ()

    init(to value: CGFloat, onEnded: @escaping () -> () = {}) {
        self.target = value
        self.value = value
        self.onEnded = onEnded // << callback
    }

    var animatableData: CGFloat {
        get { value }
        set { value = newValue
            // newValue here is interpolating by engine, so changing
            // from previous to initially set, so when they got equal
            // animation ended
            let callback = onEnded
            if newValue == target {
					DispatchQueue.main.async(execute: callback)
            }
        }
    }

    func body(content: Content) -> some View {
        content.scaleEffect(value)
    }
}


struct TestReversingScaleAnimation_Previews: PreviewProvider {
    static var previews: some View {
        TestReversingScaleAnimation()
    }
}
