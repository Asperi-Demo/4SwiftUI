// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION:     By using this you agree do not repost any part of this code
//                    on StackOverflow site. Thanks, Asperi.

import SwiftUI

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
            ZStack {
                Color.red
                List {
                    Text("Item 1")
                    Text("Item 2")
                    Text("Item 3")
                }
                .scrollContentBackground(Color.red) // Xcode 14b3+
            }
        }
    }
}

#if canImport(Charts)
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
