```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: SwiftUI: Do not refresh a custom view MacOS app (by Mickael Belhassen)

A: Here is simplified demo of possible approach. The idea is to cache created WKWebView objects by some identifiers and just reuse them in created (or recreated) thin-wrapper SwiftUI view representable.

*Tested & works with Xcode 11.2 / iOS 13.2*

    struct WebView: UIViewRepresentable {
    
        private static var cache: [Int: WKWebView] = [:]
        
        // the only allowed entry point to create WebView, so have control either
        // to create new instance of WKWebView or provide already loaded
        static func view(with id: Int, request: URLRequest) -> WebView {
            var web = cache[id] // it is UI thread so safe to access static
            if web == nil {
                web = WKWebView()
                cache[id] = web
            }
            return WebView(with: web!, request: request)
        }
        
        private init(with web: WKWebView, request: URLRequest) {
            self.web = web
            self.request = request
        }
        
        private let web: WKWebView
        private let request: URLRequest
    
        func makeUIView(context: Context) -> WKWebView  {
            if web.url == nil { // just created, so perform initial loading
                web.load(request)
            }
            return web
        }
    
        func updateUIView(_ uiView: WKWebView, context: Context) {
        }
    }
    
    // Just simple test view
    struct TestOnceLoadedWebView: View {
        private let urls: [String] = [
            "http://www.apple.com",
            "http://www.google.com",
            "http://www.amazon.com"
        ]
        
        var body: some View {
            NavigationView {
                List(0 ..< urls.count) { i in
                    NavigationLink("Link \(i)", destination:
                        WebView.view(with: i, request: 
                                     URLRequest(url: URL(string: self.urls[i])!)))
                }
            }
        }
    }

