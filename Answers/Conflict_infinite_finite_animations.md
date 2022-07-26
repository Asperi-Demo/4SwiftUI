```
🔥BOYCOTT on russia - terrorist must be punished!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: Animation triggered using a Button stops a repeatForever animation added onAppear (by Q. Eude)

A: SwiftUI animations are not added(cumulated), at least for now (SwiftUI 2.0). So here is possible workaround.

Tested with Xcode 12 / iOS 14

![Gvj0j](https://user-images.githubusercontent.com/62171579/179343239-1ee7720a-4b68-414d-8d67-483fabf01ff2.gif)

```
struct WaterWaveView: View {
    @State var progress: CGFloat = 0.1
    @State var phase: CGFloat = 0.5

    var body: some View {
        VStack {
            WaterWave(progress: self.progress, phase: self.phase)
                .fill(Color.blue)
                .clipShape(Circle())
                .frame(width: 250, height: 250)
                .animation(phase == 0 ? .default : Animation.linear(duration: 1).repeatForever(autoreverses: false), value: phase)
                .animation(.easeOut(duration: 1), value: progress)
                .onAppear {
                  self.phase = .pi * 2
                }
            Button("Add") {
              self.phase = 0    // << stop infinite
              self.progress += 0.1  // << activate finite
              DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.phase = .pi * 2   // << restart infinite
              }
            }
            Button("Reset") {
                self.progress = 0.0
            }
        }
    }
}
```
