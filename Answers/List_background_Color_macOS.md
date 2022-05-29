```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: SwiftUI background color of List Mac OS (by davidev)

A: First picture shows the origin of the issue - used scroll view is opaque by default, so added color background is there but not visible

![O5BX0](https://user-images.githubusercontent.com/62171579/170869654-a4375757-da91-425e-ab7a-be8a6fcacd3e.png)

So the solution is to find that scroll view and disable drawing background

![7ydr1](https://user-images.githubusercontent.com/62171579/170869648-8909caff-9967-496e-9c75-cbf1cff14e0e.png)

Here is possible approach to solve this, or workaround (but valid as all modifications are made via AppKit API, no hardcoding). Actually it is the same as it would turned off checkbox in XIB for scrollview holding our tableview. Tested with Xcode 11.2 / macOS 10.15.

    struct ScrollViewCleaner: NSViewRepresentable {
        
        func makeNSView(context: NSViewRepresentableContext<ScrollViewCleaner>) -> NSView {
            let nsView = NSView()
            DispatchQueue.main.async { // on next event nsView will be in view hierarchy
                if let scrollView = nsView.enclosingScrollView {
                    scrollView.drawsBackground = false
                }
            }
            return nsView
        }
        
        func updateNSView(_ nsView: NSView, context: NSViewRepresentableContext<ScrollViewCleaner>) {
        }
    }
    
    extension View {
        func removingScrollViewBackground() -> some View {
            self.background(ScrollViewCleaner())
        }
    }
    
    struct TestListBackground: View {
        var body: some View {
                List()
                {
                    ForEach(0..<3) { _ in
                        Text("Test")
                            .listRowBackground(Color.green)
                    }
                    .removingScrollViewBackground() // must be called _inside_ List
                    .background(Color.blue)
                }.background(Color.red)
        }
    }

 
