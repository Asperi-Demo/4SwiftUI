```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: SwiftUI coordinator not updating the containing view's property (by Toma)

A: Here is your code, a bit modified for demo, with used view model instance of ObservableObject holding your loading state.


    import SwiftUI
    import WebKit
    import Combine
    
    class WebViewModel: ObservableObject {
        @Published var link: String
        @Published var didFinishLoading: Bool = false
        
        init (link: String) {
            self.link = link
        }
    }
    
    struct WebView: UIViewRepresentable {
        @ObservedObject var viewModel: WebViewModel
    
        let webView = WKWebView()
    
        func makeUIView(context: UIViewRepresentableContext<WebView>) -> WKWebView {
            self.webView.navigationDelegate = context.coordinator
            if let url = URL(string: viewModel.link) {
                self.webView.load(URLRequest(url: url))
            }
            return self.webView
        }
    
        func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<WebView>) {
            return
        }
    
        class Coordinator: NSObject, WKNavigationDelegate {
            private var viewModel: WebViewModel
    
            init(_ viewModel: WebViewModel) {
                self.viewModel = viewModel
            }
    
            func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
                print("WebView: navigation finished")
                self.viewModel.didFinishLoading = true
            }
        }
    
        func makeCoordinator() -> WebView.Coordinator {
            Coordinator(viewModel)
        }
    
    }
    
    struct WebViewContentView: View {
        @ObservedObject var model = WebViewModel(link: "https://apple.com")
    
        var body: some View {
            VStack {
                TextField("", text: $model.link)
                WebView(viewModel: model)
                if model.didFinishLoading {
                    Text("Finished loading")
                        .foregroundColor(Color.red)
                }
            }
        }
    }
    
