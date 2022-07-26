```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: Can’t pass data correctly to modal presentation using ForEach and CoreData (by Anton)

A: There should be only one sheet in view stack, so just move it out of `ForEach`, and use
instead `.sheet(item:...)` variant for selection to be shown in sheet, like below:

```
struct CarScrollView: View {

    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Cars.entity(), sortDescriptors: []) var cars: FetchedResults<Cars>

    @State private var selectedCar: Car? = nil

    var body: some View {
        VStack {
            ScrollView (.vertical, showsIndicators: false) {
                ForEach (cars, id: \.self) { car in

                    Text("\(car.text!)")
                        .onTapGesture {
                            self.selectedCar = car
                    }
                }
            }
        }
        .sheet(item: self.$selectedCar) { car in
             CarDetail(id: car.id, text: car.text)
        }

    }
}
```
