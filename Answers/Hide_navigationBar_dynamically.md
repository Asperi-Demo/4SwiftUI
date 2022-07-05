```
🔥BOYCOTT on russia - terrorist must be punished!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: How to dynamically hide navigation back button in SwiftUI (by robr2112)

A: Here is working solution. Back button cannot be hidden, it is managed by bar and owned by parent view, however it is possible to hide entire navigation bar with below approach.

Tested with Xcode 11.4 / iOS 13.4

![xR5qd](https://user-images.githubusercontent.com/62171579/176757870-3e591af7-6cea-4cd1-9f8f-f19bd03c3b7f.gif)

```
struct ParentView: View {
    @State var isTimerRunning = false
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink("Go", destination: TimerTest(isTimerRunning: $isTimerRunning))
            }
            .navigationBarHidden(isTimerRunning)
            .navigationBarTitle("Main")      // << required, at least empty !!
        }
    }
}

struct TimerTest: View {
    @Binding var isTimerRunning: Bool

    var body: some View {
        Button(action:self.startTimer) {
            Text("Start Timer")
        }
    }

    func startTimer()
    {
        self.isTimerRunning = true

        _ = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { timer in
            DispatchQueue.main.async {      // << required !!
                self.isTimerRunning = false
            }
        }
    }
}
```
