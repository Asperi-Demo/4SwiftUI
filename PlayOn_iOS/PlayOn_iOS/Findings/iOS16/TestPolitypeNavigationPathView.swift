// 🔥BOYCOTT on russia - terrorist must be punished!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION:     By using this you agree do not repost any part of this code
//                    on StackOverflow site. Thanks, Asperi.

import SwiftUI

#if canImport(Charts)
@available (iOS 16, *)
struct TestPolitypeNavigationPathView: View {
    struct Foo: Hashable {}
    struct Bar: Hashable {}

    @State private var stack: NavigationPath

    init() {
        var stack = NavigationPath()
        stack.append(Bar())
        stack.append(Foo())

        _stack = State(initialValue: stack)
    }
    
    var body: some View {
        NavigationStack(path: $stack) {
            VStack {
                NavigationLink("Foo", value: Foo())
                NavigationLink("Bar", value: Bar())
                Divider()
                Button("Push") {
                    stack.append(Bar())
                }
            }
            .navigationDestination(for: Foo.self) { _ in
                Text("I'm foo")
                    .navigationTitle("Foo")
            }
            .navigationDestination(for: Bar.self) { _ in
                Button("I'm bar") {
                    stack.append(Foo())
                }
                .navigationTitle("Bar")
            }
        }
    }
}

@available (iOS 16, *)
struct TestPolitypeNavigationPathView_Previews: PreviewProvider {
    static var previews: some View {
        TestPolitypeNavigationPathView()
    }
}
#endif
