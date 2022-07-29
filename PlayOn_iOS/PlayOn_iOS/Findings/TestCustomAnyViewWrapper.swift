// 🔥BOYCOTT on russia - terrorist must be punished!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestCustomAnyViewWrapper: View {
    let views = [
        JustView(content: Label("Demo1", systemImage: "car")),
        JustView(content: Button("Demo2") { print(">> test")}),
        JustView(content: Circle().frame(width: 40, height: 40)),
//                AnyView(Label("Demo1", systemImage: "car")),
//                AnyView(Text("Demo2")),
//                AnyView(Circle().frame(width: 40, height: 40)),
    ]
    var body: some View {
        VStack {
            ForEach(views.indices, id: \.self) {
                views[$0]
                    .border(.blue)
            }
        }
        .foregroundColor(.red)
    }
}

struct JustView: View {
    private let controller: UIViewController
    
    init<V>(content: V) where V: View {
        controller = UIHostingController(rootView: content)
    }
    
    var body: some View {
        Unwrapper(controller: controller).fixedSize()
    }
    
    struct Unwrapper: UIViewControllerRepresentable {
        let controller: UIViewController
        func makeUIViewController(context: Context) -> UIViewController {
            let size = controller.view.sizeThatFits(CGSize(width: CGFloat.infinity, height: CGFloat.infinity))
            controller.preferredContentSize = size
            return controller
        }
        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        }
    }
}

struct TestCustomAnyViewWrapper_Previews: PreviewProvider {
    static var previews: some View {
        TestCustomAnyViewWrapper()
    }
}
