// 🔥BOYCOTT on russia - terrorist must be punished!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestAnimationReplacementInTransaction: View {
    @State var show: Bool = false
    @State var reverseDelay: Bool = false

    @State var delay1 = 0.3
    @State var delay2 = 0.5
    var body: some View {
        VStack {
            Button(action:{
            	withAnimation {
                	self.show.toggle()
                }
            }) {
                Text("Animate")
                    .font(.largeTitle)
            }
            if show {
                Rectangle()
                    .foregroundColor(.blue)
                    .frame(height: 100)
                    .transition(.move(edge: .trailing))
                    .transaction {
                    	$0.animation = Animation.spring().delay(delay1)
					}
                    .onAppear { self.delay1 = 0.5 }
                    .onDisappear { self.delay1 = 0.3 }
                Rectangle()
                    .foregroundColor(.yellow)
                    .frame(height: 100)
                    .transition(.move(edge: .trailing))
                    .transaction {
                    	$0.animation = Animation.spring().delay(delay2)
					}
                    .onAppear { self.delay2 = 0.3 }
                    .onDisappear { self.delay2 = 0.5 }
            }
        }
    }
}

struct TestAnimationReplacementInTransaction_Previews: PreviewProvider {
    static var previews: some View {
        TestAnimationReplacementInTransaction()
    }
}
