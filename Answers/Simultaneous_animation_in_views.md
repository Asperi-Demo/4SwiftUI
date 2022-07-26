```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: SwiftUI animation not working when embedded inside another view (by harsh_v)

A: Animation is activate on state **change**. In provided code there is no change so no animation at all.

Below are main changes so I made it work. Tested with Xcode 11.4 / iOS 13.4 (with some replication of absent custom dependencies)

![zkwwP](https://user-images.githubusercontent.com/62171579/173744051-594839b6-159b-4457-985d-548d7826bbd1.gif)

1) Made initial animation off

```
struct LoginView: View {
    @State var showProgress = false

// ... other code

    // no model provided so used same state for progress
    ProgressButton(action: {
        self.showProgress.toggle()     // << activate change !!!
    }, image: Image("password-lock"), text: L.Login.LoginSecurely, backgroundColor: self.isLoginButtonEnabled ? Color.primaryLightColor : Color.gray, showProgress: $showProgress) 

```

2) Add internal ring activating state inside progress button; same state used for hide/unhide and activating does not work, again, because when ring appeared there is no change (it is already true) so ring is not activated

    @State private var actiavteRing = false     // << here !!
    var body: some View {
        Button(action: action) {
            HStack {

                if showProgress {
                    RingView(color: textColor, show: self.$actiavteRing) // !!
                        .frame(width: 25, height: 25)
                        .transition(.opacity)
                        .animation(.spring())
                        .onAppear { self.actiavteRing = true } // << 
                        .onDisappear { self.actiavteRing = false } // <<

3) in Ring fixed animation deactivation to avoid cumulative effect (.none does not work here), so

    .rotationEffect(.degrees(show ? 360.0 : 0.0))
    .animation(show ? Animation.linear(duration: 
        1.0).repeatForever(autoreverses: false) : .default)   // << here !!


