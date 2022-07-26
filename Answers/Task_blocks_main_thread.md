```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: `Task` blocks main thread when calling async function inside (by aheze)

A: A solution is to detach long task activity into background thread and
update published property in main thread. Now (swift 5.6+) we need to
mark function for that explicitly with `MainActor`.

![ezgif com-gif-maker-36](https://user-images.githubusercontent.com/62171579/162894387-7d9423b3-a927-4b75-8673-ab66844fb141.gif)


Tested with Xcode 13.3 / iOS 15.4

		func populate() async {
			Task.detached {              // << here !!
				var items = [String]()
				for i in 0 ..< 4_000_000 { /// this usually takes a couple seconds
					items.append("\(i)")
				}
				await self.applyItems(items)   // << here !!
			}
		}

    // private redirect of published property update on main thread
		@MainActor private func applyItems(_ items: [String]) {
			self.items = items
		}

The complete module in test project [TestViewModelTaskBlocking.swift](https://github.com/Asperi-Demo/4SwiftUI/blob/master/PlayOn_iOS/PlayOn_iOS/Findings/TestViewModelTaskBlocking.swift)
