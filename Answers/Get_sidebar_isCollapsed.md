```
BOYCOTT on ᵣussia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: SwiftUI: Get sidebar isCollapsed state on macOS (by viedev)

A: Yes, dirrect access currently is not available, but internally it is still `NSSplitViewController` based
engine used, so the actuall task is to find that controller and access first split view item (which is sidebar)
in the considered scenario, so it would be possible to subscribe to `isCollapsed`, which is KVO-compliant.

Transferreing `isCollapsed` into SwiftUI level (say via `Binding`) gives us possibility to update our views.

Here is a possible approach (is is safe is that sense that no exceptions when discontinued - just stop of work).

Tested with Xcode 13.3 / macOS 12.2.1

![ezgif com-gif-maker-40](https://user-images.githubusercontent.com/62171579/164932502-45ce9ead-94d4-404c-940c-3c2845c57b82.gif)

Usage is

    @State private var collapsed = false
    ...
    NavigationView {
      SOME_CONTENT_VIEW()
          .background(SplitViewAccessor(sideCollapsed: $collapsed))   // << inject finder !!

and actually helper view to find `NSSplitViewController` and subscribe to some item to get a state

```
struct SplitViewAccessor: NSViewRepresentable {
  @Binding var sideCollapsed: Bool

  func makeNSView(context: Context) -> some NSView {
    let view = MyView()
    view.sideCollapsed = _sideCollapsed
    return view
  }

  func updateNSView(_ nsView: NSViewType, context: Context) {
  }

  class MyView: NSView {
    var sideCollapsed: Binding<Bool>?

    weak private var controller: NSSplitViewController?
    private var observer: Any?

    override func viewDidMoveToWindow() {
      super.viewDidMoveToWindow()
      var sview = self.superview

      // find split view through hierarchy
      while sview != nil, !sview!.isKind(of: NSSplitView.self) { 
        sview = sview?.superview
      }
      guard let sview = sview as? NSSplitView else { return }
      
      controller = sview.delegate as? NSSplitViewController   // delegate is our controller
      if let sideBar = controller?.splitViewItems.first {     // now observe for state
        observer = sideBar.observe(\.isCollapsed, options: [.new]) { [weak self] _, change in
          if let value = change.newValue {
            self?.sideCollapsed?.wrappedValue = value    // << here !!
          }
        }
      }
    }
  }
}
```

[Test module in project is here](https://github.com/Asperi-Demo/4SwiftUI/blob/master/PlayOn_macOS/PlayOn_macOS/Findings/TestToggleSidebar.swift)<br>
[SplitViewAccessor is here](https://github.com/Asperi-Demo/4SwiftUI/blob/master/PlayOn_macOS/PlayOn_macOS/Helpers/SplitViewAccessor.swift)
