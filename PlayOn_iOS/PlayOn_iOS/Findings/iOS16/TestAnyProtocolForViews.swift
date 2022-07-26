// 🔥BOYCOTT on russia - terrorist must be punished!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

#if canImport(Charts)

@available(iOS 16, *)
struct TestAnyProtocolForViews_Previews: PreviewProvider {
    static var previews: some View {
        TestNavigatable()
        TestConverter()
    }
}

// !!! both cases below result in `any View` which generates compiler error:
// >> Type 'any View' cannot conform to 'View'

// MARK: - Test `any` with model for use in View
@available(iOS 16, *)
protocol Provider {   // Provider<Value> is allowed by Xcode 14
    associatedtype Value
    
    func get() -> Value
}

@available(iOS 16, *)
struct S {
    var stringProvider: any Provider // Provider<String> is allowed by Xcode 14
}

@available(iOS 16, *)
struct ProviderView: View {
    let provider: any Provider       // << existential !!
    init(provider p: some Provider) { // << inferred !!
        self.provider = p
    }
    var body: some View {
        Text(String(describing: provider.get()))
    }
}

@available(iOS 16, *)
struct DummyProvider: Provider {
    typealias Value = String
    
    func get() -> String {
        "Hello World!"
    }
}

@available(iOS 16, *)
struct TestConverter: View {
    let s = S(stringProvider: DummyProvider())
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            ProviderView(provider: s.stringProvider)  // << works !!
        }
    }
}


// MARK: - Test for direct dependency on `any View`
protocol Navigatable: Identifiable {
    associatedtype V: View
    var id: Int { get }
    var destination: V { get }
}
struct HomePageGridItem<Dest: View>: Navigatable {
    var id: Int
    var destination: Dest
}

@available(iOS 16, *)
struct TestNavigatable: View {
    let dest1 = HomePageGridItem(id: 1, destination: Text("Hello"))
    let dest2 = HomePageGridItem(id: 2, destination: Image(systemName: "car"))

    let items: [any Navigatable] = [
        HomePageGridItem(id: 1, destination: Text("Hello")),
        HomePageGridItem(id: 2, destination: Image(systemName: "car"))
    ]

    var body: some View {
        HStack {
            dest2.destination
            dest1.destination
//            destination(for: items[0]) // << Type 'any View' cannot conform to 'View'
//            items[1].destination // Type 'any View' cannot conform to 'View'
        }
//        List {
//            ForEach(0..<items.count, id: \.self) { i in
//                self.destination(for: items[i])
//            }
//        }
    }
    
    func destination(for i: some Navigatable) -> some View {
        i.destination
    }
}
#endif
