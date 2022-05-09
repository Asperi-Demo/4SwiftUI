```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: WKWebView - Update HTML Tags from SwiftUI TextFields (by Niklas)

A: Here is full module of fixed variant that works with Xcode 13.2 / iOS 15.2. Fixed coordinator, of course you should always use it from context, as well several injections and communication between entities.

![1cwKQ](https://user-images.githubusercontent.com/62171579/167479512-223eab41-0d65-4960-bda7-5ca3d18da36a.gif)

*Note: see also for comments inline*

```
struct DemoView: View {
    @State private var headline: String = "Initial"

    var body: some View {
        NavigationView {
            VStack {
                Form {
                    TextField("Your headline", text: $headline)
                }
                WebView(headline: $headline)
            }
        }
    }
}

import WebKit

let bridgeHTML = """
 <!DOCTYPE html>
 <html>
 <head>
 <meta name="viewport" content="width=device-width, height=device-height, initial-scale=1, minimum-scale=1, viewport-fit=cover">
 </head>
 <body>
 <h3 id="headline">Headline</h3>
 <script>
    // to receive messages from native
      webkit.messageHandlers.bridge.onMessage = (msg) => {
        document.getElementById("headline").textContent = msg
      }
    </script>
    </body>
    </html>
"""

struct WebView: UIViewRepresentable {

    @Binding var headline: String

    class Coordinator: NSObject, WKNavigationDelegate, WKScriptMessageHandler {
        func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        }

        private var owner: WebView
        init(owner: WebView) {
            self.owner = owner
        }

        var webView: WKWebView?
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            self.webView = webView
            self.messageToWebview(msg: self.owner.headline)   // initial value loading !!
        }

        func messageToWebview(msg: String) {
            self.webView?.evaluateJavaScript("webkit.messageHandlers.bridge.onMessage('\(msg)')")
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(owner: self)
    }

    func makeUIView(context: Context) -> WKWebView {
        let userContentController = WKUserContentController()
        userContentController.add(context.coordinator, name: "bridge")

        let configuration = WKWebViewConfiguration()
        configuration.userContentController = userContentController

        let _wkwebview = WKWebView(frame: .zero, configuration: configuration)
        _wkwebview.navigationDelegate = context.coordinator

        guard let path: String = Bundle.main.path(forResource: "index", ofType: "html") else { return _wkwebview }
        let localHTMLUrl = URL(fileURLWithPath: path, isDirectory: false)
        _wkwebview.loadFileURL(localHTMLUrl, allowingReadAccessTo: localHTMLUrl)

//        _wkwebview.loadHTMLString(bridgeHTML, baseURL: nil)    // << used for testing

        return _wkwebview
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        // this works for update, but for initial it is too early !!
        webView.evaluateJavaScript("webkit.messageHandlers.bridge.onMessage('\(headline)')")
    }
}
```
