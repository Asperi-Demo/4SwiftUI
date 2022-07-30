>
> 🔥BOYCOTT on russia - terrorist must be punished!<br>
> «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
> 
> ATTENTION: This is a demo - use it as you wish. Reference is appriciated.<br>
> If you want to thank - buy me coffee: [Coffee for Asperi](https://secure.wayforpay.com/donate/asperi)
>

Q: How to access a variable of an instance of a view in ContentView SwiftUI? (by nickcoding)

A: For whatever reason it is needed technically it is possible to do via callback closure.

**Caution:** *the action in such callback should not lead to refresh sender view, otherwise it would be just either cycle or value lost*

Here is a demo of usage & solution. Tested with Xcode 11.4 / iOS 13.4

```
ViewName { sender in
    print("Use value: \(sender.vm.text)")
}
```

and

```
struct ViewName: View {

    @StateObject var vm = ViewNameViewModel()

    var callback: ((ViewName) -> Void)? = nil    // << declare

    var body: some View {
        HStack {
            TextField("Enter:", text: $vm.text)
        }.onReceive(vm.$text) { _ in
            if let callback = self.callback {
                callback(self)       // << demo of usage
            }
        }
    }
}

class ViewNameViewModel: ObservableObject {
    @Published var text: String = ""
}
```
