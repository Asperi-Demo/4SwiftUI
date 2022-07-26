```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: Right aligning a .bottomBar ToolbarItem in SwiftUI for iOS 14 (by Thor Correia)

A: Every ToolbarItem have to include single view, so just move Spacer into separated toolbar item

Tested with Xcode 12b3

![93bCI](https://user-images.githubusercontent.com/62171579/171192224-2d6d22cd-d525-478e-9373-2a7dc92eb89e.png)

        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                Spacer()
            }
            ToolbarItem(placement: .bottomBar) {
                Button(action: { print("Pressed") }) {
                    Image(systemName: "plus.circle.fill")
                        .imageScale(.large)
                        .font(.title)
                }
            }
        }

*Note: to have it centered remove toolbar item with spacer*
