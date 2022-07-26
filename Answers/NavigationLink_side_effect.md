```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: SwiftUI - NavigationLink is not working with a button (by tanvirgeek)

A: `NavigationLink` is itself a button, actually, so you introduce some kind of conflict. Instead you can use link just with additional tap gesture handler, like

    NavigationLink(destination: Text("\(self.sum)")) {
        Text("Add Two Numbers")
            .padding()
            .foregroundColor(.blue)
            .background(isTapped ? Color.orange : Color.gray)
            .font(.title)
            .border(Color.blue, width: 5)
            .shadow(radius: 10)
        }
        .simultaneousGesture(TapGesture().onEnded{
            print("I am here in the action")
            self.isTapped.toggle()
            UIApplication.shared.endEditing()
            if let num1 = Double(self.number1), let num2 = Double(self.number2){
                print("I am here")
                self.sum = num1 + num2
                print("\(self.sum)")
            }
        })


