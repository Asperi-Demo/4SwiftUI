```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: Add horizontal padding to TextEditor but prevent it from shifting scrollbar inside as a result (by Barrrdi)

A: You added padding to external frame, but need to indent internal text container. The possible solution (as TextEditor is actually UITextView) to use appearance. So the solution would be to add the following in parent view of `TextEditor`

![Screenshot 2022-06-24 at 07 52 47](https://user-images.githubusercontent.com/62171579/175464730-2b7e2c7c-1bd0-4452-bbc1-12b6b21ea009.png)


```
  init() {
    UITextView.appearance().textContainerInset =
      UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)   // << !!
  }
  @State private var text = lorem
  var body: some View {
    VStack(alignment: .leading) {
      Text("Description:")
      TextEditor(text: $text)
        .background(Color.white)
        .foregroundColor(Color.black)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .font(.body)
        .lineSpacing(8)
    }
  }
```

Tested with Xcode 12 / iOS 14
