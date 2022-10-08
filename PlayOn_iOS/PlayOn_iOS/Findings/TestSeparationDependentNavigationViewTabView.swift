// 🔥BOYCOTT on russia - terrorist must be punished!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestSeparationDependentNavigationViewTabView: View {
    @State private var selection = 1   // can be enum
    @State private var height = CGFloat.zero
    @State private var tabBarVisible = true
    @State private var linkedTag: Int?
    
    var body: some View {
        ZStack {
            TabView(selection: $selection) {
                GeometryReader { gp in
                    Color.clear.onAppear {
                        height = gp.size.height
                    }.onChange(of: gp.size) { _ in
                        height = gp.size.height
                    }
                }
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }.tag(1)
                Color.clear
                    .tabItem {
                        Image(systemName: "bookmark.circle.fill")
                        Text("Bookmark")
                    }.tag(2)
            }
            .accentColor(.red)
            
            NavigationView {
                Group {
                   if selection == 1 {
                     view1
                   } else {
                     view2
                   }
                }
                .onAppear {
                   tabBarVisible = true // << new variant !!
                }
            }
            .frame(maxHeight: tabBarVisible ? height : .infinity)
            .frame(maxHeight: .infinity, alignment: .top)
            .onChange(of: linkedTag) { tag in
                if tag != nil {
                   tabBarVisible = false  // << new variant !!
                }
                // tabBarVisible = tag == nil    // << old variant
            }
        }
    }
    
    private var view1: some View {
        List {
            NavigationLink(tag: 1, selection: $linkedTag) {
                DetailsView()
            } label: {
                Text("View 1")
            }
        }
        .navigationTitle("View 1")
    }
    
    private var view2: some View {
        List {
            NavigationLink(tag: 2, selection: $linkedTag) {
                DetailsView()
            } label: {
                Text("View 2")
            }
        }
        .navigationTitle("View 2")
    }

    struct DetailsView: View {
        var body: some View {
            EmptyView()
        }
    }
}

struct TestSeparationDependentNavigationViewTabView_Previews: PreviewProvider {
    static var previews: some View {
        TestSeparationDependentNavigationViewTabView()
    }
}
