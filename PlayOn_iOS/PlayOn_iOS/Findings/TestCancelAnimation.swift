// 🔥BOYCOTT on russia - terrorist must be punished!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION:     By using this you agree do not repost any part of this code
//                    on StackOverflow site. Thanks, Asperi.

import SwiftUI

struct TestCancelAnimation: View {

    @State private var alignmentBool: Bool = Bool()
    @State private var activeAnimation: Bool = Bool()

    var body: some View {

        ZStack {

            Color.gray.overlay(Circle().frame(width: 100, height: 100, alignment: .center), alignment: alignmentBool ? .top : .bottom)
                .animation(!activeAnimation ? Animation.easeInOut(duration: 5) : nil, value: [alignmentBool, activeAnimation])
				.id(activeAnimation)        // << here !!

            HStack {
                Button("Move it!") { alignmentBool.toggle() }
                Spacer()
                Button("Active/Inactive") { activeAnimation.toggle() }
            }
            .foregroundColor(Color.yellow)
            .font(Font.largeTitle.bold())
            .padding()

        }
    }
}

struct TestCancelAnimation_Previews: PreviewProvider {
    static var previews: some View {
        TestCancelAnimation()
    }
}
