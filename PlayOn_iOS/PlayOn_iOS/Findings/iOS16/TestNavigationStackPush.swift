// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION:     By using this you agree do not repost any part of this code
//                    on StackOverflow site. Thanks, Asperi.

import SwiftUI

#if canImport(Charts)
@available(iOS 16.0, *)
struct TestNavigationStackPush: View {
    var body: some View {
        ContentView()
    }
    
    struct ContentView: View {
        enum Dest: Hashable {
            case search, details
        }
        @State private var path: [Dest] = []
        var body: some View {
            NavigationStack(path: $path) {
                Button("Go search") { path.append(.search) }  // << here !!
                Divider()
                NavigationLink(value: Dest.search) {
                    Text("Search")
                }
                .navigationDestination(for: Dest.self) {
                    switch $0 {
                    case .search:
                        Text("Search Destination Here")
                    case .details:
                        Text("Details Destination Here")
                    }
                }
            }
        }
    }
}

@available(iOS 16.0, *)
struct TestNavigationStackPush_Previews: PreviewProvider {
    static var previews: some View {
        TestNavigationStackPush()
    }
}

#endif
