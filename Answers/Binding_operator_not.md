```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: SwiftUI: How to use `!` operator before `$` bindable object operator? (by Master AgentX)

A: As I said in comment to question there were approach posted for [SwiftUI: transform Binding into another Binding](https://github.com/Asperi-Demo/4SwiftUI/blob/master/Answers/Negate_Binding.md). If you, however, want to have it explicitly as operator, you can use the following (tested & works with Xcode 11.2)

    extension Binding where Value == Bool {
        static prefix func !(_ lhs: Binding<Bool>) -> Binding<Bool> {
            return Binding<Bool>(get:{ !lhs.wrappedValue }, 
                                 set: { lhs.wrappedValue = !$0})
        }
    }
