// BOYCOTT on ᵣussia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard
//
// ATTENTION: 	By using this you agree do not repost any part of this code
//					on StackOverflow site. Thanks, Asperi.

import SwiftUI

struct TestToggleSidebar: View {
	@State private var collapsed = false
    var body: some View {
        NavigationView {
			VStack {
				List {
					NavigationLink("Show", destination: DetailsView(collapsed: collapsed))
				}
			}
			.background(SplitViewAccessor(sideCollapsed: $collapsed))

			DetailsView(collapsed: collapsed)
		  }
    }

	 struct DetailsView: View {
	 	let collapsed: Bool
	 	var body: some View {
			VStack(spacing: 24) {
				Text("Sidebar: \(collapsed ? "collapsed" : "expanded")")
				Button("Toggle") {
					 NSApp.keyWindow?.firstResponder?.tryToPerform(
					 #selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
				}
			}
		}
	 }
}

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
			while sview != nil, !sview!.isKind(of: NSSplitView.self) {
				sview = sview?.superview
			}
			guard let sview = sview as? NSSplitView else { return }
			controller = sview.delegate as? NSSplitViewController
			if let sideBar = controller?.splitViewItems.first {
				observer = sideBar.observe(\.isCollapsed, options: [.new]) { [weak self] _, change in
					if let value = change.newValue {
						self?.sideCollapsed?.wrappedValue = value
					}
				}
			}
		}
	}
}

struct TestToggleSidebar_Previews: PreviewProvider {
    static var previews: some View {
        TestToggleSidebar()
    }
}
