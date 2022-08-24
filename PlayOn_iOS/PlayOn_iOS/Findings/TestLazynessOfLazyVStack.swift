import SwiftUI

struct TestLazynessOfLazyVStack: View {
    var body: some View {
// 1) Only in ScrollView onAppear is not called
//        ScrollView {
// 2) In clipped/non-clipped container (out of bounds) - appeared
//        Rectangle().stroke(.red)
//            .frame(width: 200, height: 500)
//            .overlay(
        LazyVStack {
            Circle().frame(width: 100).aspectRatio(contentMode: .fit)
// 3) offset out of screen - appeared
//                    .offset(y: 150)
// 4) positioned out of screen - appeared
//                    .position(y: 150)
                .onAppear {
                    print(">> sub: appeared")
                }
        }
// 5) aligned out of screen - appeared
        .frame(width: 150, height: 1000, alignment: .bottom)
        .border(.green)
//        }
//            )
//            .clipped()
    }
}

struct TestLazynessOfLazyVStack_Previews: PreviewProvider {
    static var previews: some View {
        TestLazynessOfLazyVStack()
    }
}
