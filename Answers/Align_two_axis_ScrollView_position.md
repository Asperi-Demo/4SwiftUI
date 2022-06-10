```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: SwiftUI: How to set position of ScrollView to Top Left? (both scrolls is enabled) (by Andrew____Pls_Support_Ukraine)

A: ### Update: Xcode 13.4 / macOS 12.4

The issue is still there, but now the solution is simpler using ScrollViewReader:

Demo:

![uXnWu](https://user-images.githubusercontent.com/62171579/173133250-6d62080e-d001-4c3f-bcc6-fa5a2a5d278c.gif)


```
struct TestTwoAxisScrollView: View {
    var body: some View {
    ScrollViewReader { sp in
      ScrollView([.horizontal, .vertical]) {
        VStack {
          ForEach(0..<100) { _ in
            self.row()
          }
        }
        .border(Color.green)
        .id("root")
      }
      .border(Color.gray)
      .padding()
      .onAppear {
        sp.scrollTo("root", anchor: .topLeading)
      }
    }
    }

    func row() -> some View {
        Text(test)
            .border(Color.red) // uncomment to see border
    }
}
```

### Original

Here is possible approach. Tested with Xcode 11.2 / macOS 10.15.3

Code (complete testable module, borders are added for better visibility of each component):

    import SwiftUI
    
    let test = """
    <document type="com.apple.InterfaceBuilder3.CocoaTouch.Storyboard.XIB" version="3.0" toolsVersion="12118" systemVersion="16A323" targetRuntime="iOS.CocoaTouch" propertyAccessControl="none" useAutolayout="YES" launchScreen="YES" useTraitCollections="YES" colorMatched="YES" initialViewController="01J-lp-oVM">
    """
    
    struct ScrollViewHelper: NSViewRepresentable {
        func makeNSView(context: NSViewRepresentableContext<ScrollViewHelper>) -> NSView {
            let view = NSView(frame: .zero)
            DispatchQueue.main.async { // << must be async, so view got into view hierarchy
                view.enclosingScrollView?.contentView.scroll(to: .zero)
                view.enclosingScrollView?.reflectScrolledClipView(view.enclosingScrollView!.contentView)
            }
            return view
        }
    
        func updateNSView(_ nsView: NSView, context: NSViewRepresentableContext<ScrollViewHelper>) {
        }
    }
    
    struct TestTwoAxisScrollView: View {
        var body: some View {
            ScrollView([.horizontal, .vertical]) {
                VStack {
                    ForEach(0..<100) { _ in
                        self.row()
                    }
                }
                .background(ScrollViewHelper()) // << active part !!
                .border(Color.green) // uncomment to see border
            }
            .border(Color.gray)
            .padding()
        }
    
        func row() -> some View {
            Text(test)
                .border(Color.red) // uncomment to see border
        }
    }
    
