>
> 🔥BOYCOTT on russia - terrorist must be punished!<br>
> «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
> 
> ATTENTION: This is a demo - use it as you wish. Reference is appriciated.<br>
> If you want to thank - buy me coffee: [Coffee for Asperi](https://secure.wayforpay.com/donate/asperi)
>

Q: Binding Value Source Deleted (by Matt Bart)

A: There are two reasons in this case: constant ForEach, and refresh racing with direct biding.

Here is a solution that fixes crash and works as expected. Tested with Xcode 11.4 / iOS 13.4.

```
struct TestDeleteLast: View {
    @State var values: [Int] = [0, 1, 1, 1]
    var totalBalls: Int {
        return values.count
    }
    var body: some View {
        HStack {
            Text("\(totalBalls)")
        VStack {
            // use index as id in ForEach
            ForEach(Array(values.enumerated()), id: \.0.self) { i, _ in
                CustomView(value: Binding(   // << use proxy binding !!
                    get: { self.values[i] },
                    set: { self.values[i] = $0 }))
            }
            .onLongPressGesture {
                self.values.removeLast()
            }
        }
        }
    }
}
```
