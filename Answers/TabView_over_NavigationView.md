>
> 🔥BOYCOTT on russia - terrorist must be punished!<br>
> «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
> 
> ATTENTION: This is a demo - use it as you wish. Reference is appriciated.<br>
> If you want to thank - buy me coffee: [Coffee for Asperi](https://secure.wayforpay.com/donate/asperi)
>

Q: SwiftUI, setting title to child views of TabView inside of NavigationView does not work (by ZhouX)

A: The idea is to join `TabView` selection with `NavigationView` content dynamically. 

Demo:

![7R52E](https://user-images.githubusercontent.com/62171579/181809266-7608a61d-e07a-4f5e-8414-bc792735b7a1.gif)

Here is simplified code depicting approach (with using your views). The `NavigationView` and `TabView` just position independently in `ZStack`, but content of `NavigationView` depends on the selection of `TabView` (which content is just stub), thus they don't bother each other. Also in such case it becomes possible to hide/unhide `TabView` depending on some condition - in this case, for simplicity, presence of root list view.

    struct TestTabsOverNavigation: View {
    
        @State private var tabVisible = true
        @State private var selectedTab: Int = 0
        var body: some View {
            ZStack(alignment: .bottom) {
                contentView
                tabBar
            }
        }
    
        var contentView: some View {
            NavigationView {
                ListView(gender: selectedTab == 0 ? .female : .male)
                .onAppear {
                    withAnimation {
                        self.tabVisible = true
                    }
                }
                .onDisappear {
                    withAnimation {
                        self.tabVisible = false
                    }
                }
            }
        }
    
        var tabBar: some View {
            TabView(selection: $selectedTab) {
                Rectangle().fill(Color.clear).tag(0).tabItem {
                    TabItem(image: "person.crop.circle", label: Gender.female.rawValue)
                }
                Rectangle().fill(Color.clear).tag(1).tabItem {
                    TabItem(image: "person.crop.circle.fill", label: Gender.male.rawValue)
                }
            }
            .frame(height: 50) // << !! might be platform dependent
            .opacity(tabVisible ? 1.0 : 0.0)
        }
    }

