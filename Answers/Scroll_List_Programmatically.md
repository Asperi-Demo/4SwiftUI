```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: How to scroll List programmatically in SwiftUI? (by me)

A: 
**SWIFTUI 2.0**

Here is possible alternate solution in Xcode 12 / iOS 14 (SwiftUI 2.0) that can be used in same scenario when controls for scrolling is outside of scrolling area (because SwiftUI2 `ScrollViewReader` can be used only *inside* `ScrollView`)

*Note: Row content design is out of consideration scope* 

Tested with Xcode 12b / iOS 14

![NZYrv](https://user-images.githubusercontent.com/62171579/162632340-4f3c1816-b3a0-4c47-84e7-779099cf452e.gif)


```
class ScrollToModel: ObservableObject {
    enum Action {
        case end
        case top
    }
    @Published var direction: Action? = nil
}

struct ContentView: View {
    @StateObject var vm = ScrollToModel()

    let items = (0..<200).map { $0 }
    var body: some View {
        VStack {
            HStack {
                Button(action: { vm.direction = .top }) { // < here
                    Image(systemName: "arrow.up.to.line")
                      .padding(.horizontal)
                }
                Button(action: { vm.direction = .end }) { // << here
                    Image(systemName: "arrow.down.to.line")
                      .padding(.horizontal)
                }
            }
            Divider()
            
            ScrollViewReader { sp in
                ScrollView {
               
                    LazyVStack {
                        ForEach(items, id: \.self) { item in
                            VStack(alignment: .leading) {
                                Text("Item \(item)").id(item)
                                Divider()
                            }.frame(maxWidth: .infinity).padding(.horizontal)
                        }
                    }.onReceive(vm.$direction) { action in
                        guard !items.isEmpty else { return }
                        withAnimation {
                            switch action {
                                case .top:
                                    sp.scrollTo(items.first!, anchor: .top)
                                case .end:
                                    sp.scrollTo(items.last!, anchor: .bottom)
                                default:
                                    return
                            }
                        }
                    }
                }
            }
        }
    }
}
```

**SWIFTUI 1.0+**

Here is simplified variant of approach that works, looks appropriate, and takes a couple of screens code. 

Tested with Xcode 11.2+ / iOS 13.2+ (also with Xcode 12b / iOS 14)

**Demo of usage:**

```
struct ContentView: View {
    private let scrollingProxy = ListScrollingProxy() // proxy helper

    var body: some View {
        VStack {
            HStack {
                Button(action: { self.scrollingProxy.scrollTo(.top) }) { // < here
                    Image(systemName: "arrow.up.to.line")
                      .padding(.horizontal)
                }
                Button(action: { self.scrollingProxy.scrollTo(.end) }) { // << here
                    Image(systemName: "arrow.down.to.line")
                      .padding(.horizontal)
                }
            }
            Divider()
            List {
                ForEach(0 ..< 200) { i in
                    Text("Item \(i)")
                        .background(
                           ListScrollingHelper(proxy: self.scrollingProxy) // injection
                        )
                }
            }
        }
    }
}
```

![mzFYb](https://user-images.githubusercontent.com/62171579/162632362-347deedf-94ee-42e0-974b-a52afef43df9.gif)


**Solution:**

Light view representable being injected into `List` gives access to UIKit's view hierarchy. As `List` reuses rows there are no more values then fit rows into screen.

```
struct ListScrollingHelper: UIViewRepresentable {
    let proxy: ListScrollingProxy // reference type

    func makeUIView(context: Context) -> UIView {
        return UIView() // managed by SwiftUI, no overloads
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        proxy.catchScrollView(for: uiView) // here UIView is in view hierarchy
    }
}
```

Simple proxy that finds enclosing `UIScrollView` (needed to do once) and then redirects needed "scroll-to" actions to that stored scrollview

```
class ListScrollingProxy {
    enum Action {
        case end
        case top
        case point(point: CGPoint)     // << bonus !!
    }

    private var scrollView: UIScrollView?

    func catchScrollView(for view: UIView) {
        if nil == scrollView {
            scrollView = view.enclosingScrollView()
        }
    }

    func scrollTo(_ action: Action) {
        if let scroller = scrollView {
            var rect = CGRect(origin: .zero, size: CGSize(width: 1, height: 1))
            switch action {
                case .end:
                    rect.origin.y = scroller.contentSize.height +
                        scroller.contentInset.bottom + scroller.contentInset.top - 1
                case .point(let point):
                    rect.origin.y = point.y
                default: {
                    // default goes to top
                }()
            }
            scroller.scrollRectToVisible(rect, animated: true)
        }
    }
}

extension UIView {
    func enclosingScrollView() -> UIScrollView? {
        var next: UIView? = self
        repeat {
            next = next?.superview
            if let scrollview = next as? UIScrollView {
                return scrollview
            }
        } while next != nil
        return nil
    }
}
```
