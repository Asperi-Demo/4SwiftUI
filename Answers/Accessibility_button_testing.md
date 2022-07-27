>
> 🔥BOYCOTT on russia - terrorist must be punished!<br>
> «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
> 
> ATTENTION: This is a demo - use it as you wish. Reference is appriciated.<br>
> If you want to thank - buy me coffee: [Coffee for Asperi](https://secure.wayforpay.com/donate/asperi)
>

Q: Assert that Image exists on button in UITest (by L3n95)

A: Accessibility engine does not see internals of button, but if you change like

```
Button(action: {
    self.highlighted = !self.highlighted
}) {
    if self.highlighted {
        Image("highlighted").resizable()
    } else {
       Text("Text")
    }
}
```

then you can verify toggle by UT (tested with Xcode 12.1 / iOS 14.1)

```
func test_highlight() {
    let app = XCUIApplication()
	app.launch()
    let button = app.buttons["Text"]     // << fits button label
    XCTAssertTrue(button.exists)
    button.tap()

    let highlighted_button = app.buttons["highlighted"] // fits button image name
    XCTAssertTrue(highlighted_button.exists)
}
```

**Update:** possible variant for transparent image

```
struct DemoView: View {
	@State private var highlighted = false
	var body: some View {
		Button(action: {
			 self.highlighted = !self.highlighted
		}) {
			 ZStack {
				  Text("Text")
				  if self.highlighted {
						Image("flag-1").resizable()
				  }
			 }
		}
		.accessibility(identifier: highlighted ? "highlighted" : "button" )
	}
}

func test_highlight() {
	 let app = XCUIApplication()
	 app.launch()
	 let button = app.buttons["button"]
	 XCTAssertTrue(button.exists)
	 button.tap()

	 let highlighted = app.buttons["highlighted"]
	 XCTAssertTrue(highlighted.exists)
}
```
