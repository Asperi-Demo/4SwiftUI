```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: Making a shape the size of the parent view in SwiftUI (by GiulioFerDev)

A: Here is applied same idea as commented to your scenario. Of course it is only sketch, but IMO it can be tuned as far as needed and made generic (replacing currently used `Text` with, say, `View` or `FullFraction` itself to construct more complex fractions).

Demo (as DispatchQueue is used to avoid modification during view draw warning you should run it to see result):

![h6q3A](https://user-images.githubusercontent.com/62171579/170479812-b0894fdf-5089-4a2c-a21e-e7fc3a97a8c0.png)

Code (of screenshot demo):

    struct FullFraction: View {
        var whole: String = ""
        var num: String
        var denom: String
    
        @State private var numWidth: CGFloat = 12.0 // just initial
        @State private var denomWidth: CGFloat = 12.0 // just initial
        var body: some View {
            HStack {
                Text(whole)
                VStack {
                    numerator
                    divider
                    denominator
                }
            }
        }
        var numerator: some View {
            Text(num)
                .offset(x: 0, y: 8)
                .alignmentGuide(HorizontalAlignment.center, computeValue: { d in
                    DispatchQueue.main.async {
                        self.numWidth = d.width
                    }
                    return d[HorizontalAlignment.center]
                })
        }
        var denominator: some View {
            Text(denom)
            .offset(x: 0, y: -4)
            .alignmentGuide(HorizontalAlignment.center, computeValue: { d in
                DispatchQueue.main.async {
                    self.denomWidth = d.width
                }
                return d[HorizontalAlignment.center]
            })
        }
    
        var divider: some View {
            Rectangle().fill(Color.black).frame(width:max(self.numWidth, self.denomWidth), height: 2.0)
        }
    }
    
    struct DemoFraction: View {
        var body: some View {
            VStack {
                FullFraction(whole: "F", num: "(a + b)", denom: "c")
                Divider()
                FullFraction(whole: "ab12", num: "13", denom: "761")
                Divider()
                FullFraction(num: "1111", denom: "3")
            }
        }
    }
