// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

#if canImport(Charts)
@available (iOS 16, *)
struct TestListBackgroundiOS16: View {
    var body: some View {
        ContentView()
    }
    
    struct ContentView: View {
        init() {
// [Legacy]
//            UICollectionView.appearance().backgroundColor = .clear
        }
        var body: some View {
            List {
                Text("Item 1")
                Text("Item 2")
                Text("Item 3")
            }
            .scrollContentBackground(.hidden) // Xcode 14b4+
            .background(Color.blue)
        }
    }
}

// [Legacy]
//extension UICollectionReusableView {
//    override open var backgroundColor: UIColor? {
//        get { .clear }
//        set {
//            // uncomment below to have same saparators
//            // color as background, they also uses this property
//            // super.backgroundColor = .red
//        }
//    }
//}

@available (iOS 16, *)
struct TestListBackgroundiOS16_Previews: PreviewProvider {
    static var previews: some View {
        TestListBackgroundiOS16()
    }
}
#endif
