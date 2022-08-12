>
> 🔥BOYCOTT on russia - terrorist must be punished!<br>
> «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
> 
> ATTENTION: This is a demo - use it as you wish. Reference is appriciated.<br>
> If you want to thank - buy me coffee: [Coffee for Asperi](https://secure.wayforpay.com/donate/asperi)
>

Q: How to make the view full frame even if Sidebar is on in SwiftUI? (by Chat Dp)

A: A simple solution is to use transparent content for right side and place map *below* `NavigationView`.

Here is a demo of approach. Tested with Xcode 13 / macOS 12

![RtJ6L](https://user-images.githubusercontent.com/62171579/184375065-d68ffb79-6843-4cb5-aafa-50d3e76de4b2.gif)


    var body: some View {
        ZStack {
            MapView()                // << content here !!
            
            NavigationView {
                List(0 ..< 5) { item in
                    NavigationLink("Test") {
                        VStack {
                            Text("Test")
                        }
                        .navigationTitle("Test")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .ignoresSafeArea()
                    }
                }
                Color.clear         // << transparent right !!
            }
            .frame(minWidth: 400, minHeight: 400)
            .toolbar {
                ToolbarItem(placement: .navigation) {
                    Button(action: toggleSidebar, label: {
                        Image(systemName: "sidebar.leading")
                    })
                }
            }
        }
    }
