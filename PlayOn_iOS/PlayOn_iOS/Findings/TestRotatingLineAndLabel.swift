// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestRotatingLineAndLabel: View {

    @State var angle = Angle.zero

    var body: some View {
        VStack {
            Spacer()

            LineAndLabel()
                .rotationEffect( angle, anchor: .bottomLeading )
                .animation(.easeInOut(duration: 1.0),
                                      value: angle)
                .padding()

            Spacer()

            Button("Change Angle") {
                angle = ( angle == Angle.zero )
                        ? Angle( degrees: -90.0 )
                        : Angle( degrees:  0.0)
            }
            Spacer()
        }
    }
}

struct LineAndLabel: View {
    var body: some View {
        HStack {
            SimpleLine().stroke()
            Text("A Label")
        }
        .fixedSize(horizontal: false, vertical: true)  // << here !!
    }
}

struct SimpleLine: Shape {
    func path(in rect: CGRect) -> Path {

        var path = Path()
        path.move( to: CGPoint( x: 0, y: rect.height ))
        path.addLine(to: CGPoint( x: rect.width, y: rect.height ) )
        return path
    }
}
struct TestRotatingLineAndLabel_Previews: PreviewProvider {
    static var previews: some View {
        TestRotatingLineAndLabel()
    }
}
