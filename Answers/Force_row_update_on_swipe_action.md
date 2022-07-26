```
🔥BOYCOTT on russia - terrorist must be punished!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: SwiftUI: Force List Row to adjust height to content (by Adam)

A: List caches created rows, so we need to let it known that specific row should be rebuilt from scratch. The possible solution is to use `.id` dependent on same condition as optional error text.

Tested with Xcode 13.2 / iOS 15.2

![ESkbB](https://user-images.githubusercontent.com/62171579/178040993-c99d6f97-310f-4f36-940b-54d2545349e6.gif)

Here is modified part of code (some extra added for demo):

    .swipeActions(edge: .leading, allowsFullSwipe: true) {
      Button(action: {
      	if nil == self.error[item] {
        	self.error[item] = "ERROR!"
			} else {
				self.error[item] = nil
			}
      }) {
        Image(systemName: "square.and.arrow.up")
      }.background(Color.blue)
    }
    .id(item + (self.error[item] ?? ""))   // << here !!

