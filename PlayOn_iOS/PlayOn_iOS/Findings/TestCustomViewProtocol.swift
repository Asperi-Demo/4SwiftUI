// 🔥BOYCOTT on russia - terrorist must be punished!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestCustomViewProtocol: View {
    var body: some View {
        TestView()
    }

    fileprivate struct TestView: CombinedView {
        typealias AView = Text
        
        var viewB: some View {
            Image(systemName: "car")
        }
        
        var dataForViewA: String = "Hello"
    }
}

struct TestCustomViewProtocol_Previews: PreviewProvider {
    static var previews: some View {
        TestCustomViewProtocol()
    }
}

fileprivate protocol CombinedView: View {
    associatedtype AView: View
    associatedtype BView: View

    var dataForViewA: String { get }

    var viewA: Self.AView { get }
    var viewB: Self.BView { get }
}

fileprivate extension CombinedView {
    var body: some View {
        VStack {
            viewA
            viewB
        }
    }
}

fileprivate extension CombinedView where AView == Text {
    var viewA: Text {
        Text(dataForViewA)
    }
}

