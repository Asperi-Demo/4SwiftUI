// 🔥BOYCOTT on russia - terrorist must be punished!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestAlignmentGuideReplacement: View {
    @State private var isOn = false
    var body: some View {
        VStack {
        	FirstView()
                .background(
                	SecondView()
						.alignmentGuide(isOn ? HorizontalAlignment.trailing : .leading) { dim in
							dim[HorizontalAlignment.center]
						}
						.alignmentGuide(VerticalAlignment.bottom) { dim in
							dim[VerticalAlignment.top]
						}
                    ,alignment: isOn ? .bottomTrailing : .bottomLeading)
        }
        .padding(.horizontal, 32)
        .animation(.spring().repeatForever(autoreverses: true), value: isOn)
        .onAppear { isOn.toggle() }
    }

	struct FirstView: View {
		var body: some View {
            Rectangle().fill(Color.yellow).frame(height: 60)
            	.overlay(Text("Stop russia NOW").bold().foregroundColor(.blue))
		}
	}
	struct SecondView: View {
		var body: some View {
			Rectangle().fill(Color.red).frame(width: 40, height: 18)
		}
	}

}

struct TestAlignmentGuideReplacement_Previews: PreviewProvider {
    static var previews: some View {
        TestAlignmentGuideReplacement()
    }
}
