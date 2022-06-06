```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: Updating SwiftUI navigation bar title (by Alex)

A: Put navigation title modifier inside `Picker`. Also as same Text view from `Picker` item is used to present selection in `Form` we need to make Options title conditional.

Here is a demo of approach. Tested with Xcode 12.4 / iOS 14.4

![gDFR6](https://user-images.githubusercontent.com/62171579/172104872-1dbeebb0-3620-4a69-ae5d-b20035a0a0f4.gif)

    Form {
        Picker(selection: $currentSelection, label: Text("Options")) {
            ForEach(0 ..< options.count) {
				if $0 != currentSelection {
                   Text(options[$0])
					.navigationBarTitle("Options", displayMode: .inline)
				} else {
                   Text(options[$0])
				}
            }
        }
    }
    .navigationBarTitle("Settings", displayMode: .inline)

