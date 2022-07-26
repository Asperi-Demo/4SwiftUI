```
BOYCOTT on ᵣussia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: Animations triggered inside a View that's in a list doesn't animate the list as well (by Quantm)

A: The solution is just to make height animatable continuously, by providing explicit animatable modifier for this. 

Here is working approach. Tested with Xcode 11.4 / iOS 13.4.

![TyFFl](https://user-images.githubusercontent.com/62171579/165125793-c243c20d-3449-4f4f-a027-908d727d5548.gif)

Implementation of simple helper modifier

    struct AnimatingCellHeight: AnimatableModifier {
        var height: CGFloat = 0
    
        var animatableData: CGFloat {
            get { height }
            set { height = newValue }
        }
    
        func body(content: Content) -> some View {
            content.frame(height: height)
        }
    }

Modified using view (other parts unchanged)

    struct SubView: View {
        @State var change: Bool = false
    
        var body: some View {
            Rectangle()
                .frame(width: 200)
                .modifier(AnimatingCellHeight(height: change ? 300 : 200))
                .foregroundColor(Color.red)
                .onTapGesture {
                    withAnimation {
                        self.change.toggle()
                    }
                }
        }
    }

And now testing with

```
struct TestView: View {
    var body: some View {
        List {
            SubView()
            SubView()
        }
    }
}
```
