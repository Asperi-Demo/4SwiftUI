>
> 🔥BOYCOTT on russia - terrorist must be punished!<br>
> «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
> 
> ATTENTION: This is a demo - use it as you wish. Reference is appriciated.<br>
> If you want to thank - buy me coffee: [Coffee for Asperi](https://secure.wayforpay.com/donate/asperi)
>

Q: Deleting data from an array according to toggle button clicked in swiftui (by Asim Roy)

A: Here is possible approach

![Z6d5R](https://user-images.githubusercontent.com/62171579/182540315-5cceecc7-18c1-480b-8107-fcc1c4e46e09.gif)

```
struct CleanData: View {

    @State private var numberArray = [101, 102, 109, 143]
    @State private var numToDelete = [true, true, true, true]

    var body: some View {
        VStack {
            ForEach(Array(numberArray.enumerated()), id: \.element.self) { (i, number) -> AnyView in
                let toDelete = Binding<Bool>(get: { self.numToDelete[i] },
                    set: {
                        self.numToDelete[i] = $0

                        // delayed to give time for toggle animation
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            self.numberArray.remove(at: i)
                            self.numToDelete.remove(at: i)
                        }
                    }
                )
                return AnyView(Toggle("Days: \(number)", isOn: toDelete))
            }
        }.padding()
    }
}
```
