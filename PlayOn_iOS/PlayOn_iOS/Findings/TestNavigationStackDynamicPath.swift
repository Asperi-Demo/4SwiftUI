// 🔥BOYCOTT on russia - terrorist must be punished!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION:     By using this you agree do not repost any part of this code
//                    on StackOverflow site. Thanks, Asperi.

import SwiftUI

#if canImport(Charts)
struct TestNavigationStackDynamicPath: View {
    var body: some View {
        // Replace any below with test module to demo !!
        if #available(iOS 16.0, *) {
            //            LandingPageView(navigationState: NavState())
            LandingPageView2(navigationState: LandingPageView2.NavState())
        } else {
            EmptyView()
        }
    }
}

@available (iOS 16, *)
struct LandingPageView2: View {
    class NavState: ObservableObject {
        @Published var path = NavigationPath()
        let level1 = [
            "a" : ["bb", "ba"],
            "b" : ["bb", "ba"]
        ]
        let level2 = [
            "bb" : ["baa", "bbb"],
            "ba" : ["baa", "bbb"]
        ]
    }
    struct Lev1: Hashable {
        var text: String
    }
    struct Lev2: Hashable {
        var text: String
    }
    struct Lev3: Hashable {
        var text: String
    }
    
    func resetNav() {
        self.navigationState.path.append(Lev1(text: "b"))
        self.navigationState.path.append(Lev2(text: "ba"))
        self.navigationState.path.append(Lev3(text: "bbb"))
    }
    
    @ObservedObject var navigationState: NavState
    var body: some View {
        NavigationStack(path: $navigationState.path) {
            List {
                NavigationLink("a", value: Lev1(text: "a"))
                NavigationLink("b", value: Lev1(text: "b"))
                Button(action: self.resetNav) {
                    Text("Set Nav")
                }
            }
            .navigationDestination(for: Lev1.self) {
                Place(text: $0.text, childValues: navigationState.level1[$0.text] ?? [])
            }
            .navigationDestination(for: Lev2.self) {
                NextPlace(text: $0.text, childValues: navigationState.level2[$0.text] ?? [])
            }
            .navigationDestination(for: Lev3.self) {
                FinalPlace(text: $0.text)
            }
            .navigationBarTitle("Start")
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .environmentObject(navigationState)
    }
    
    // MARK: -
    struct Place: View {
        var text: String
        var childValues: [String]
        
        var body: some View {
            List(childValues, id: \.self) {
                NavigationLink($0, value: Lev2(text: $0))
            }
            .navigationTitle(text)
        }
    }
    struct NextPlace: View {
        var text: String
        var childValues: [String]
        
        var body: some View {
            List(childValues, id: \.self) {
                NavigationLink($0, value: Lev3(text: $0))
            }
            .navigationTitle(text)
        }
    }
    struct FinalPlace: View {
        var text: String
        @EnvironmentObject var navigationState: NavState
        
        var body: some View {
            VStack {
                Text(text)
            }
        }
    }
}

struct TestNavigationStackDynamicPath_Previews: PreviewProvider {
    static var previews: some View {
        TestNavigationStackDynamicPath()
    }
}
#endif
