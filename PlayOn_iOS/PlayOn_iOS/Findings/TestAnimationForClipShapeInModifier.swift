// 🔥BOYCOTT on russia - terrorist must be punished!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestAnimationForClipShapeInModifier: View {
    @State private var text = ""
    var body: some View {
        TextField("placeholder", text: $text)
            .textFieldStyle(.roundedBorder)
            .addRightIcon(icon: Image(systemName: "checkmark"), show: isTextValid)
        
        
    }
    var isTextValid: Bool {
        if !text.isEmpty {
            return text.count > 3
        }
        return false
    }
}

extension View {
    func addRightIcon(icon: Image, show: Bool) -> some View {
        return modifier(RightIconModifier(icon: icon, show: show))
    }
}

struct RightIconModifier: ViewModifier {
    
    var icon: Image
    var show: Bool    // << injected changes
    
    func body(content: Content) -> some View {
        ZStack {
            content
                .overlay(rightIcon)
        }
    }
    
    var rightIcon: some View {
        icon
            .font(.system(size: 25))
            .foregroundColor(.black)
            .frame(maxWidth: .infinity,
                   maxHeight: .infinity,
                   alignment: .trailing)
            .padding()
            .clipShape(Rectangle().offset(x: CGFloat(show ? 0 : -50))) // << switch is here !!
            .animation(.easeIn(duration: 1), // << simplified for testing
                       value: show)
    }
}


struct TestAnimationForClipShapeInModifier_Previews: PreviewProvider {
    static var previews: some View {
        TestAnimationForClipShapeInModifier()
    }
}
