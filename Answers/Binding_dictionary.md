```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: How to Bind a Value of a Dictionary to a SwiftUI Control? (by Jack B. Erger)

A: Most quick solution is to use wrapper binding, as in below snapshot

```
class AppData: ObservableObject {
    @Published var dataPoints: [UUID : DataPoint] = [:] {
    ...
}

...

Slider(value: Binding<Double>(
    get: { self.appData.dataPoints[self.dataPointID]?.value ?? 0 },
    set: { self.appData.dataPoints[self.dataPointID]?.value = $0}), in: 0...10000)
```
