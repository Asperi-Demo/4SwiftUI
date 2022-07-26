```
🔥BOYCOTT on russia - terrorist must be punished!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: How to make a simple up and down floating animation in SwitfUI? (by Susca Bogdan)

A: Updated: Xcode 13.4 / iOS 15.5

Here is possible simple approach. Tested with Xcode 11.4 / iOS 13.4. Of course parameters can be tuned by needs.

![DNoMj](https://user-images.githubusercontent.com/62171579/180136652-6b2f907b-4378-4cc0-964f-b29048201017.gif)

    struct BoncingView: View {
        @State private var bouncing = false
        var body: some View {
            Text("Hello, World!")
                .frame(maxHeight: .infinity, alignment: bouncing ? .bottom : .top)
                .animation(Animation.easeInOut(duration: 5.0).repeatForever(autoreverses: true), value: bouncing)
                .onAppear {
                    self.bouncing.toggle()
                }
        }
    }
