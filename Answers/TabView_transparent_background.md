```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: Make TabView Background Transparent (by Caleb Kleveter)

A: The hosting view of every tab has system background color (which is opaque).

![TX1eL](https://user-images.githubusercontent.com/62171579/175459873-5b32af30-8be1-4538-8555-b22dd225d11b.png)

Here is possible workaround. Tested with Xcode 12 / iOS 14

![BvchS](https://user-images.githubusercontent.com/62171579/175459896-20ad50f2-5b6c-4577-a2b8-66af6c1e996d.png)

```
struct BackgroundHelper: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        DispatchQueue.main.async {
            // find first superview with color and make it transparent
            var parent = view.superview
            repeat {
                if parent?.backgroundColor != nil {
                    parent?.backgroundColor = UIColor.clear
                    break
                }
                parent = parent?.superview
            } while (parent != nil)
        }
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.orange.edgesIgnoringSafeArea(.all)

            // Sub-view inlined
            TabView {
                VStack {
                    Text("Hello World")
                    Button("Press Me", action: { print("Pressed") })
                }
                .background(BackgroundHelper())  // add to each tab if needed
                .tabItem {
                    Text("First Page")
                }
                Text("Second")
                    .background(BackgroundHelper())  // add to each tab if needed
                    .tabItem {
                        Text("Second Page")
                    }
            }
        }
    }
}
```
