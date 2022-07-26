```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: SwiftUI Why do my buttons on my list view stop working if I have too many items on the list view? (by John Robinson)

A: Well, in this case it is an issue of modelling... The `@State` is view state property, so `List` having cached views, for optimisation & reuse purpose, preserves the view internal state itself. Thus in such scenarios state cannot be used for persistency purpose and it is required to have explicit view model, and actually it is true for all model cases.

Here is modified demo code, using view model based on `ObservableObject` and `@Binding` for inter-view data pass, that works properly...

    import SwiftUI
    import Combine
    
    // model to keep groceries
    struct FoodItem: Identifiable {
        var id = UUID().uuidString
        var title: String
        var checked = false
    }
    
    // view model part 
    class FoodViewModel: ObservableObject {
        @Published var items = [FoodItem]()
    }
    
    struct CheckboxFieldView : View {
        @Binding var item: FoodItem // bind to represented model
        var body: some View {
             Button(action:
                {
                    self.item.checked.toggle()
            }) {
                       Rectangle()
                                .fill(self.item.checked ? Color.green : Color.red)
                                .frame(width:20, height:20, alignment: .center)
                                .cornerRadius(5)
            }
            .foregroundColor(Color.white)
        }
    }
    
    struct ContentView: View {
    
        @ObservedObject private var viewModel = FoodViewModel()
        let items = ["Bread", "Milk", "Cheese", "Granola", "Nuts", "Cereal", "Rosemary", "Tomato Sauce", "Bean with Bacon Soup", "Tea", "Chocolate Milk", "Frozen Blueberries", "Frozen Mixed Berries", "Frozen Strawberries", "Grapes"]
    
        init() {
            viewModel.items = items.map { FoodItem(title: $0) } // fill in demo model items
        }
    
        var body: some View {
            NavigationView {
                List(Array(viewModel.items.enumerated()), id: \.element.id) { (i, item) in
                    HStack{
                        CheckboxFieldView(item: self.$viewModel.items[i]) // bind to current item in view model
                        Text(item.title)
                        Spacer()
                        Text ("Location")
                    }
                }.navigationBarTitle("Grocery List", displayMode: .inline)
            }
        }
    }
    
