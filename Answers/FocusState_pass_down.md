```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: Passing down @FocusState to another view (by Luis Ramirez)

A: You can pass its binding as argument, like

```
struct View1: View {
  enum Field {
    case username, password
  }

  @State var passwordText: String = ""
  @FocusState var focusedField: Field?

  var body: some View {
    View2(text: $passwordText, placeholder: "Password", focused: $focusedField)
  }
}

struct View2: View {
  @Binding var text: String
  let placeholder: String
  var focused: FocusState<View1.Field?>.Binding     // << here !!

  var body: some View {
    HStack {
        TextField(placeholder, text: $text)
            .frame(minHeight: 44)
            .padding(.leading, 8)
            .focused(focused, equals: .password)     // << here !!
        if text.count > 0 {
            Image(systemName: "xmark.circle.fill")
                .font(.headline)
                .foregroundColor(.secondary)
                .padding(.trailing, 8)
        }

    }
  }
}
```
