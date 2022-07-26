// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

#if canImport(Charts)
struct TestBindingDestinationNavigationStack: View {
    var body: some View {
        if #available(iOS 16.0, *) {
            ParentListView()
        } else {
            EmptyView()
        }
    }

    @available (iOS 16.0, *)
    struct ParentListView: View {
        @State private var numbers = [1, 2, 3, 4, 5]
        var body: some View {
            NavigationStack {
                List {
                    ForEach($numbers) { number in
                        NavigationLink(value: number) {
                            Text("\(number.wrappedValue)")
                        }
                    }
                }
                .navigationDestination(for: Binding<Int>.self) { number in
                    ChildDetailView(number: number)
                }
            }
        }
    }
    struct ChildDetailView: View {
        @Binding var number: Int
        var body: some View {
            VStack {
                Text("\(number)")
                Button {
                    number += 10
                } label: {
                    Text("Add 10")
                }
            }
        }
    }
}

struct TestBindingDestinationNavigationStack_Previews: PreviewProvider {
    static var previews: some View {
        TestBindingDestinationNavigationStack()
    }
}
#endif

extension Binding: Equatable where Value: Equatable {
    public static func == (lhs: Binding<Value>, rhs: Binding<Value>) -> Bool {
        return lhs.wrappedValue == rhs.wrappedValue
    }
}

extension Binding: Hashable where Value: Hashable {
    public func hash(into hasher: inout Hasher) {
        self.wrappedValue.hash(into: &hasher)
    }
}

