```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: SwiftUI WKWebView content height issue (by Mahi008)

A: It is confusing of `ScrollView` in SwiftUI, which expects known content size in advance, and `UIWebView` internal `UIScrollView`, which tries to get size from parent view... cycling.

So here is possible approach.. to pass determined size from web view into SwiftUI world, so no hardcoding is used and `ScrollView` behaves like having flat content.

At first demo of result, as I understood and simulated ...

![PIqWg](https://user-images.githubusercontent.com/62171579/163428180-887670f8-eeed-421a-9c25-cb5efb23e234.gif)

Here is complete module code of demo. *Tested & worked on Xcode 11.2 / iOS 13.2.*

    import SwiftUI
    import WebKit
    
    struct Webview : UIViewRepresentable {
        @Binding var dynamicHeight: CGFloat
        var webview: WKWebView = WKWebView()
    
        class Coordinator: NSObject, WKNavigationDelegate {
            var parent: Webview
    
            init(_ parent: Webview) {
                self.parent = parent
            }
    
            func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
                webView.evaluateJavaScript("document.documentElement.scrollHeight", completionHandler: { (height, error) in
                    DispatchQueue.main.async {
                        self.parent.dynamicHeight = height as! CGFloat
                    }
                })
            }
        }
    
        func makeCoordinator() -> Coordinator {
            Coordinator(self)
        }
    
        func makeUIView(context: Context) -> WKWebView  {
            webview.scrollView.bounces = false
            webview.navigationDelegate = context.coordinator
            let htmlStart = "<HTML><HEAD><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0, shrink-to-fit=no\"></HEAD><BODY>"
            let htmlEnd = "</BODY></HTML>"
            let dummy_html = """
                            <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec ut venenatis risus. Fusce eget orci quis odio lobortis hendrerit. Vivamus in sollicitudin arcu. Integer nisi eros, hendrerit eget mollis et, fringilla et libero. Duis tempor interdum velit. Curabitur</p>
                            <p>ullamcorper, nulla nec elementum sagittis, diam odio tempus erat, at egestas nibh dui nec purus. Suspendisse at risus nibh. Mauris lacinia rutrum sapien non faucibus. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec interdum enim et augue suscipit, vitae mollis enim maximus.</p>
                            <p>Fusce et convallis ligula. Ut rutrum ipsum laoreet turpis sodales, nec gravida nisi molestie. Ut convallis aliquet metus, sit amet vestibulum risus dictum mattis. Sed nec leo vel mauris pharetra ornare quis non lorem. Aliquam sed justo</p>
                            """
            let htmlString = "\(htmlStart)\(dummy_html)\(htmlEnd)"
            webview.loadHTMLString(htmlString, baseURL:  nil)
            return webview
        }
    
        func updateUIView(_ uiView: WKWebView, context: Context) {
        }
    }
    
    
    struct TestWebViewInScrollView: View {
        @State private var webViewHeight: CGFloat = .zero
        var body: some View {
            ScrollView {
                VStack {
                    Image(systemName: "doc")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 300)
                    Divider()
                    Webview(dynamicHeight: $webViewHeight)
                        .padding(.horizontal)
                        .frame(height: webViewHeight)
                }
            }
        }
    }
    
   
