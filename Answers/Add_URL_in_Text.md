```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: Tappable portions within a string for SwiftUI (by Dan Selig)

A: A possible approach - use string formatted by Markdown and either allow to open URLs directly by system or intercept clicks by using custom scheme.

Tested with Xcode 13.3 / iOS 15.4

![HOnDm](https://user-images.githubusercontent.com/62171579/168412041-e0894604-0f90-4ce6-bad9-3b003d563f7d.png)

Registered custom URL sceme in app:

![Screenshot 2022-05-14 at 08 27 22](https://user-images.githubusercontent.com/62171579/168412058-bf31e3ac-10ce-4610-bd25-ba079db7d634.png)

And code:

```
struct ContentView: View {
  @Environment(\.openURL) var openURL
  var body: some View {
    Text("here is a phone: [xxx-xxx-xxxx](tel:xxx-xxx-xxxx) and here is a link: [apple.com](asperi://apple.com). Go for it.")
      .onOpenURL {
        print(">> got: \($0)")
        print("preprocess & forward")
        if let host = $0.host, let url = URL(string: "https://" + host) {
          openURL(url)
        }
      }
  }
}
```

or directly with open URL action, like

    Text("here is a phone: [xxx-xxx-xxxx](tel:xxx-xxx-xxxx) and here is a link: [apple.com](asperi://apple.com). Go for it.")
      .environment(\.openURL, OpenURLAction { url in
          handleURL(url) // << handle inside your function
          return .handled
      })
