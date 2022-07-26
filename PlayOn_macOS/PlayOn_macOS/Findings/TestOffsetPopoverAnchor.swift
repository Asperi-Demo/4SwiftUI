// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestOffsetPopoverAnchor: View {
    @State private var isPop = false
    @State private var text = ""

    var body: some View {
        VStack{
            Button { self.isPop.toggle() }
            	label: { Text("Pop").padding() }
            	.buttonStyle(.plain)
				.border(.blue)
				.padding(.horizontal, -8)  // << here !!
				.border(.yellow)
                .popover(isPresented: $isPop,
                         attachmentAnchor: .point(.bottomTrailing),
                         arrowEdge: .bottom) {
                    VStack { // just example
                        Text("Test").padding(.top)
                        TextField("Placeholder", text: self.$text)
                            .padding(.horizontal)
                            .padding(.bottom)
                            .frame(width: 200)
                    }
            }
        }.frame(width: 300, height: 200)
    }
}

struct TestOffsetPopoverAnchor_Previews: PreviewProvider {
    static var previews: some View {
        TestOffsetPopoverAnchor()
    }
}
