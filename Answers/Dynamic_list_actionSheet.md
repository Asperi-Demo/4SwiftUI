```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: SwiftUI - Dynamic list of buttons in ActionSheet (by Ken Chung)

A: Here is possible solution. 

## Update: Xcode 13.3 / iOS 15.4

Now `actionSheet` is replaced with `confirmationDialog` which accepts view builder, so now it is just doable inside, like

	.confirmationDialog("", isPresented: $showSheet) {
		ForEach(currentOptions.indices, id: \.self) { i in
			Button(currentOptions[i]) { self.option = i + 1 }
		}
	}

## Deprecated:

Tested with Xcode 11.4 / iOS 13.4

having helper function

    func generateActionSheet(options: [String]) -> ActionSheet {
        let buttons = options.enumerated().map { i, option in
            Alert.Button.default(Text(option), action: { self.option = i + 1 } )
        }
        return ActionSheet(title: Text("Select an option"), 
                   buttons: buttons + [Alert.Button.cancel()])
    }

you then can use

```
.actionSheet(isPresented: self.$showSheet, content: {
   // assuming you have `currentOptions` (or similar) property for dynamic
   // options
   self.generateActionSheet(options: self.currentOptions)
})
```
