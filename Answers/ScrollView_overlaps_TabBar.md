```
🔥BOYCOTT on russia - terrorist must be punished!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: ScrollView overlaps Text in VStack when hiding TabBar (by the.blaggy)

A: It is because by default `Text` view is transparent, so you just see scroll view content below it.

Here is a demo of possible solution

![hBgEb](https://user-images.githubusercontent.com/62171579/176986151-96774d00-2b5c-4d95-9d65-feacafd4e5dd.png)

    VStack {
        ScrollView {
            ForEach(0..<50) { idx in
                Text("\(idx)")
            }
        }
        Text("Just some text so visualize the overlapping")
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color(UIColor.systemBackground))
            .edgesIgnoringSafeArea(.bottom)
    }


Another possible alternate is to clip ScrollView content

![BKFOh](https://user-images.githubusercontent.com/62171579/176986149-1e642e29-7fad-4cb3-9758-25353e69125e.png)

    ScrollView {
        ForEach(0..<50) { idx in
            Text("\(idx)")
        }
    }
    .clipped()

