```
🔥BOYCOTT on russia - terrorist must be punished!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: How to stop timer in Text view? (by fankibiber)

A: Here is a demo of possible approach - as `.timer` run from now for ever (by design), the idea is to replace it with regular text once specified period is over. 

Tested with Xcode 12b3 / iOS 14.

![6ddcd](https://user-images.githubusercontent.com/62171579/178145030-2d5044e2-d032-475e-8e35-7d9951fa64be.gif)

```
struct DemoView: View {
    @State private var run = false

    var body: some View {
        VStack {
            if run {
                Text(nextRollTime(in: 10), style: .timer)
            } else {
                Text("0:00")
            }
        }
        .font(Font.system(.title, design: .monospaced))
        .onAppear {
            self.run = true
        }
    }

    func nextRollTime(in seconds: Int) -> Date {
        let date = Calendar.current.date(byAdding: .second, value: seconds, to: Date())
        DispatchQueue.main.asyncAfter(deadline: .now() + Double(seconds)) {
            self.run = false
        }
        return date ?? Date()
    }
}
```
