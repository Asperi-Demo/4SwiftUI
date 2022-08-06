// 🔥BOYCOTT on russia - terrorist must be punished!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

#if canImport(Charts)
@available (iOS 16, *)
struct TestShowNavBarWhenScrolling: View {
    @State private var barHidden = true
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack {
                    ForEach(0 ..< 3) { _ in
                        Image(systemName: "rectangle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .padding()
                    }
                }.background(GeometryReader {
                    Color.clear.preference(key: ViewOffsetKey.self,
                       value: -$0.frame(in: .named("scroll")).origin.y)
                })
                .onPreferenceChange(ViewOffsetKey.self) {
                    if !barHidden && $0 < 50 {
                        barHidden = true
                        print("<< hiding")
                    } else if barHidden && $0 > 50{
                        barHidden = false
                        print(">> showing")
                    }
                }
            }.coordinateSpace(name: "scroll")
                .navigationBarTitle("Stop russia NOW!", displayMode: .inline)
                .navigationBarHidden(barHidden)
        }
        .animation(.default, value: barHidden)
        .edgesIgnoringSafeArea(.all)
    }
}

@available (iOS 16, *)
struct TestShowNavBarWhenScrolling_Previews: PreviewProvider {
    static var previews: some View {
        TestShowNavBarWhenScrolling()
    }
}
#endif
