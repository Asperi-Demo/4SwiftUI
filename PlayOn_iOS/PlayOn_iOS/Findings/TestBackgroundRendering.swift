// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestBackgroundRendering_Previews: PreviewProvider {
    static var previews: some View {
        TestBackgroundRendering()
    }
}

struct TestableView: View {
    var body: some View {
        VStack {
            Text("Test 1")
            Text("Test 2")
        }
    }
}

struct TestBackgroundRendering: View {
    var body: some View {
        VStack {
            TestableView()
            Divider()
            Image(uiImage: render())
                .border(Color.black)
        }
    }

    private func render() -> UIImage {
        TestableView().asImage()
    }
}
