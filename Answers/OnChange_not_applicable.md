```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: SwiftUI can not add onChange event (by M1X)

A: If the `messages` is a `@Published` the following should work

```
struct MessagesView: View {
    @ObservedObject var messagesViewModel: MessagesViewModel
    
    var body: some View {
        VStack {
            ScrollView(.vertical, showsIndicators: false, content: {
                ScrollViewReader { reader in
                    VStack(spacing: 20) {
                        ForEach(messagesViewModel.request.messages) { message in
                            Text(message.text)
                                .id(message.id)
                        }
                        .onReceive(messagesViewModel.request.$messages) { (value) in
                           guard !value.isEmpty else { return } 
                           reader.scrollTo(value.last!.id)
                        }
                    }
                }
            })
        }
    }
}
```
