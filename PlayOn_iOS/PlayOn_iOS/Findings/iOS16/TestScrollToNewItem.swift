// 🔥BOYCOTT on russia - terrorist must be punished!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestScrollToNewItem: View {
    @State private var items = [Int]()
    
    var body: some View {
        ScrollViewReader { sr in
            ScrollView(showsIndicators: false) {
                LazyVStack {
                    ForEach(items, id: \.self) { index in
                        // content
                        Text("\(index)").id(index).font(.system(size: 64))
                        // ... it is appeared, so we can use transition
                            .transition(index == items.last ? .opacity : .identity)
                            .onAppear {
                                // on last appeared scedule add next ...
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.82) {
                                    if index == items.last && index < 50 {
                                        items.append(index + 1)
                                    }
                                    DispatchQueue.main.async {
                                        // ... and animate scrolling to it after add
                                        withAnimation {
                                            sr.scrollTo(index + 1)
                                        }
                                    }
                                }
                            }
                    }
                }
                // animates transitions
                .animation(.easeIn(duration: 0.7), value: items.count)
            }
            .onAppear {
                items.append(1)
            }
        }
    }
}

struct TestScrollToNewItem_Previews: PreviewProvider {
    static var previews: some View {
        TestScrollToNewItem()
    }
}
