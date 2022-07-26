// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestGridNonClip: View {
    @State private var imageNames: [String]

    private let threeColumnGrid = [
        GridItem(.flexible(minimum: 40), spacing: 0),
        GridItem(.flexible(minimum: 40), spacing: 0),
        GridItem(.flexible(minimum: 40), spacing: 0),
    ]

    init() {
        _imageNames = State(initialValue: (0..<8).map { _ in
            "background"
        })
    }

    var body: some View {
        LazyVGrid(columns: threeColumnGrid, alignment: .leading, spacing: 0) {
            ForEach(imageNames.indices, id: \.self) { i in
                Image(imageNames[i]).resizable()
                    .aspectRatio(1, contentMode: .fill)
                    .border(Color.black)
                    .offset(x: i == 5 ? 20 : 0)        // << here !!
            }
        }
        .border(.red)
        .padding()
    }
}

struct TestGridNonClip_Previews: PreviewProvider {
    static var previews: some View {
        TestGridNonClip()
    }
}
