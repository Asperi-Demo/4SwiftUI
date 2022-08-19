>
> 🔥BOYCOTT on russia - terrorist must be punished!<br>
> «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
> 
> ATTENTION: This is a demo - use it as you wish. Reference is appriciated.<br>
> If you want to thank - buy me coffee: [Coffee for Asperi](https://secure.wayforpay.com/donate/asperi)
>

Q: SwiftUI - Pass Enum as Parameter to View (by kittonian)

class Sample: ObservableObject {

    @Published var enum1: Enum1 = .main
    @Published var enum2: Enum2 = .foo
    @Published var enum3: Enum3 = .add

    enum Enum1 {
        case main
        case test
    }

    enum Enum2 {
        case foo
        case blah
    }

    enum Enum3 {
        case add
        case remove
    }
}

A: With pretty amount of doubts I would suppose that you want to write a value into environment object by key path... if I'm right then it can be done as follows

```
struct MultipleUseView<T>: View {
    @EnvironmentObject var sample: Sample

    // bad practice to name vars as keywords, but if you insist...
    var `enum`: ReferenceWritableKeyPath<Sample, T>
    var destination: T

    var body: some View {
        Button {
            sample[keyPath: `enum`] = destination // << here !!
        } label: {
            Text("Tap Me")
        }
    }
}

struct TestView: View {
    @EnvironmentObject var sample: Sample

    var body: some View {
        MultipleUseView(enum: \.enum1, destination: .main)
    }
}
```
