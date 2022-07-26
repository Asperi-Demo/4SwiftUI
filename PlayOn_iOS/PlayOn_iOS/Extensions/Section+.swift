// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

extension Section where Parent == Text, Content: View, Footer == EmptyView {
    init(_ title: LocalizedStringKey, content: @escaping () -> Content) {
        self.init(header: Text(title), content: content)
    }
}
