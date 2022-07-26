// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

public extension Binding where Value == Bool {
    func negate() -> Binding<Bool> {
        return Binding<Bool>(get:{ !self.wrappedValue },
            set: { self.wrappedValue = !$0})
    }
}

public extension Binding where Value == Bool {

    static func ||(_ lhs: Binding<Bool>, _ rhs: Binding<Bool>) -> Binding<Bool> {
        return Binding<Bool>( get: { lhs.wrappedValue || rhs.wrappedValue },
                              set: {_ in })
    }
}
