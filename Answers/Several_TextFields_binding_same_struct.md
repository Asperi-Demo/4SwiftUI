```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: Message in console on iOS 15: "Binding<String> action tried to update multiple times per frame." (by Bart van Kuik)
  
A: This warning is generated due to simultaneous update due to binding to entire model, like
  
    TextField("Username", text: self.$credential.username)
  
  Here is a possible safe workaround - use inline separated binding for each text field:

```
struct UsernamePasswordInput: View {
    @Binding var credential: Credential

    var body: some View {
        Group {
            TextField("Username", text: Binding(
            	get: { credential.username },
            	set: { credential.username = $0 }
				))
            SecureField("password", text: Binding(
            	get: { credential.password },
            	set: { credential.password = $0 }
				))
        }
        .textFieldStyle(RoundedBorderTextFieldStyle())
    }
}
```

Tested with Xcode 13 / iOS 15
