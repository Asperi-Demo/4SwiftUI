>
> 🔥BOYCOTT on russia - terrorist must be punished!<br>
> «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
> 
> ATTENTION: This is a demo - use it as you wish. Reference is appriciated.<br>
> If you want to thank - buy me coffee: [Coffee for Asperi](https://secure.wayforpay.com/donate/asperi)
>

Q: How to observe changes in UserDefaults? (by Zorgan)

A: Here is possible solution - using dynamic property extension in UserDefaults and 
combine publisher:

```
import Combine

// define key for observing
extension UserDefaults {
    @objc dynamic var status: String {
        get { string(forKey: "status") ?? "OFFLINE" }
        set { setValue(newValue, forKey: "status") }
    }
}

class Station: ObservableObject {
    @Published var status: String = UserDefaults.standard.status {
        didSet {
            UserDefaults.standard.status = status
        }
    }

    private var cancelable: AnyCancellable?
    init() {
        cancelable = UserDefaults.standard.publisher(for: \.status)
            .sink(receiveValue: { [weak self] newValue in
                guard let self = self else { return }
                if newValue != self.status { // avoid cycling !!
                    self.status = newValue
                }
            })
    }
}
```

**Note: SwiftUI 2.0** allows you to use/observe `UserDefaults` in view directly via `AppStorage`, so if you need that status only in view, you can just use

```
struct SomeView: View {
    @AppStorage("status") var status: String = "OFFLINE"
    ...
```
