```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
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
