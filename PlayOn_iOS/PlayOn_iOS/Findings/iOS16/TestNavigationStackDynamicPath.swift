// 🔥BOYCOTT on russia - terrorist must be punished!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

#if canImport(Charts)
@available (iOS 16, *)
struct TestNavigationStackDynamicPath: View {
    var body: some View {
        LandingPageView2(navigationState: LandingPageView2.NavState())
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

@available (iOS 16, *)
struct TestNavigationStackDynamicPath_Previews: PreviewProvider {
    static var previews: some View {
        TestNavigationStackDynamicPath()
    }
}
#endif
