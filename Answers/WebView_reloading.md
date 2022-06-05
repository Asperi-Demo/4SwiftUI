```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: SwiftUI: WKWebView not loading (by netshark1000)

A: You try to apply 'reference'-base approach to value based SwiftUI views. It is not allowed, so does not work. In your usage code `webView` in button action and in below are different independent values (because WebView is struct).

So here is possible approach. Tested with Xcode 11.4 / iOS 13.4

![bLlAp](https://user-images.githubusercontent.com/62171579/172042001-6d238989-ba5a-43b6-9bb7-64429d81e8ff.gif)

```
struct TestWebView: View {
    @State private var shouldRefresh = false
    var body: some View {
        VStack{
            Button(action: {
                self.shouldRefresh = true
            }){
                Text("Reload")
            }
            WebView(url: nil, reload: $shouldRefresh)
        }
    }
}


struct WebView: UIViewRepresentable{

    var url: URL?     // optional, if absent, one of below search servers used
    @Binding var reload: Bool

    private let urls = [URL(string: "https://google.com/")!, URL(string: "https://bing.com")!]
    private let webview = WKWebView()

    fileprivate func loadRequest(in webView: WKWebView) {
        if let url = url {
            webView.load(URLRequest(url: url))
        } else {
            let index = Int(Date().timeIntervalSince1970) % 2
            webView.load(URLRequest(url: urls[index]))
        }
    }

    func makeUIView(context: UIViewRepresentableContext<WebView>) -> WKWebView {
        loadRequest(in: webview)
        return webview
    }

    func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<WebView>) {
        if reload {
            loadRequest(in: uiView)
            DispatchQueue.main.async {
                self.reload = false     // must be async
            }
        }
    }
}
```
