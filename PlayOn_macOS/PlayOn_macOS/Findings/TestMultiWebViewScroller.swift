import SwiftUI
import WebKit

struct TestMultiWebViewScroller: View {
	var body: some View {
		ContentView()
	}

	struct ContentView: View {
		var body: some View {
			VStack {
				ScrollViewX {
					HStack {

						WebViewX(url: "https://www.apple.com")
							.frame(width: 500)
						WebViewX(url: "https://www.google.com")
							.frame(width: 500)
						WebViewX(url: "https://www.stackoverflow.com")
							.frame(width: 500)
						WebViewX()
							.frame(width: 500)

					}.border(.green)
				}.border(.red)

			}
		}
	}


	struct ScrollViewX<Content : View>: NSViewRepresentable {
		let content: Content

		init(@ViewBuilder content: () -> Content) {
			self.content = content()
		}

		func makeNSView(context: Context) -> CustomScrollView {
			let view = CustomScrollView(frame: .zero)
			let child = NSHostingView(rootView: content)
			child.translatesAutoresizingMaskIntoConstraints = false
			view.documentView = child
			child.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
			child.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
			child.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
			return view
		}

		func updateNSView(_ nsView: CustomScrollView, context: Context) {
		}
	}

	class CustomScrollView: NSScrollView {

		override init(frame frameRect: NSRect) {
			super.init(frame: frameRect)
			self.drawsBackground = false
			self.hasHorizontalScroller = true
			self.hasVerticalScroller = false

			self.translatesAutoresizingMaskIntoConstraints = false
		}

		required init?(coder: NSCoder) {
			fatalError("init(coder:) has not been implemented")
		}

	}

	struct WebViewX: NSViewRepresentable {
		var url: String? = nil

		func makeNSView(context: Context) -> customWebView {
			let webView = customWebView(url: url)
			return webView
		}

		func updateNSView(_ NSView: customWebView, context: Context) {
		}
	}

	class customWebView : WKWebView {
		convenience init(url : String?) {


			let config = WKWebViewConfiguration()

			config.limitsNavigationsToAppBoundDomains = false
			config.preferences.isTextInteractionEnabled = true
			config.preferences.setValue(true, forKey: "fullScreenEnabled")
			config.preferences.javaScriptCanOpenWindowsAutomatically = true
			config.defaultWebpagePreferences.allowsContentJavaScript = true
			self.init(frame: .zero, configuration : config)

			self.allowsBackForwardNavigationGestures = false
			self.allowsMagnification = true

			self.translatesAutoresizingMaskIntoConstraints = false

			let req = URLRequest(url: URL(string: url ?? "https://www.youtube.com")!)

			self.load(req)

		}

		convenience required init?(coder: NSCoder) {
			fatalError("init(coder:) has not been implemented")
		}

	}

}

struct TestMultiWebViewScroller_Previews: PreviewProvider {
	static var previews: some View {
		TestMultiWebViewScroller()
	}
}
