```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: Is there a way to blur the background of a tapped element in SwiftUI? (by blub)

A: Here is a demo of possible approach (as required behaviour not completely clear). 

Tested with Xcode 11.4 / iOS 13.4

![j4AFn](https://user-images.githubusercontent.com/62171579/171717523-ce227f5a-2bd0-40d8-b07e-5ab5ee766fc8.gif)

```
struct DemoBlurImages: View {
    let images = ["sun.max", "moon", "cloud"]

    @State private var selected: String? = nil

    var body: some View {
        VStack {
            ForEach(images, id: \.self) { name in
                Image(systemName: name).resizable()
                    .onTapGesture {
                        if self.selected == name {
                            self.selected = nil
                        } else {
                            self.selected = name
                        }
                    }
                    .blur(radius: self.selected != nil && self.selected != name ? 10 : 0)
                    .scaleEffect(self.selected == name ? 1.2 : 1)
            }
        }
        .animation(.spring())
        .scaledToFit()
        .frame(width: 100)
    }
}
```
