// 🔥BOYCOTT on russia - terrorist must be punished!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

#if canImport(Charts)
@available (iOS 16, *)
struct TestNavigationStackReset: View {
    enum Item: String, Hashable {
        case home
        case one, two, three, four, five, six
    }
    
    @State private var path = [Item]()
    
    var body: some View {
        NavigationStack(path: $path) {
                ItemView(item: .home)
            .navigationDestination(for: Item.self) {
                if $0 == .five {
                    Button("Reset") {
//                        self.path = [.one, .two]
                        self.path.removeAll()
                    }
                } else {
                    ItemView(item: $0)
                }
            }
        }
    }
    
    struct ItemView: View {
        let item: Item

        init(item: Item) {
            self.item = item
            print(">> created \(item)")
        }
        
        var body: some View {
            let _ = print("== body \(item)")

            VStack {
                Text("I'm = \(item.rawValue)")
                NavigationLink("Next 1", value: Item.one)
                NavigationLink("Next 2", value: Item.two)
                NavigationLink("Next 3", value: Item.three)
                NavigationLink("Next 4", value: Item.four)
                NavigationLink("Next 5", value: Item.five)
                NavigationLink("Next 6", value: Item.six)
            }
        }
    }
}

@available (iOS 16, *)
struct TestNavigationStackReset_Previews: PreviewProvider {
    static var previews: some View {
        TestNavigationStackReset()
    }
}
#endif
