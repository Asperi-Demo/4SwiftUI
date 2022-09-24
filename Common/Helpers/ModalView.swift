// 🔥BOYCOTT on russia - terrorist must be punished!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct ModalView<C>: ViewModifier where C: View {
    @Binding var isShowing: Bool
    let content: () -> C

    @State private var interactive: Bool   // track state

    init(isShowing: Binding<Bool>, @ViewBuilder content: @escaping () -> C) {
        self._isShowing = isShowing
        self._interactive = State(initialValue: !isShowing.wrappedValue)
        self.content = content
    }

    func body(content: Content) -> some View {
        ZStack {
            content.zIndex(0).disabled(!interactive)   // disable here !!
            if self.isShowing {
                self.content()
                    .background(Color.primary.colorInvert())
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                    .transition(.move(edge: .bottom))
                    .zIndex(1)
                    .onAppear { self.interactive = false }     // << !!
                    .onDisappear { self.interactive = true }   // << !!
            }
        }
    }
}
