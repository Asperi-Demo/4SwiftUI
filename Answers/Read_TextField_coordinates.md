```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: SwiftUI Get Coordinates of TextField or any View (by JohnSF)

![YR5Qr](https://user-images.githubusercontent.com/62171579/167905923-f6cad1f2-c9ca-4221-a73f-8c127295db77.png)

A: Here is a demo of how specific view coordinates can be read (see helpful comments inline)

```
struct DemoReadViewOrigin: View {

    @State private var someNumber1 = "1000"
    @State private var someNumber2 = "2000"
    //bunch more

    @State private var enteredNumber = "Some Text at the Top"
    @State var value: CGFloat = 0

    var body: some View {
        ScrollView {
            VStack {
                Spacer()
                Text("\(enteredNumber)")
                Spacer()

                Group { //1
                    TextField("Placeholder", text: $someNumber1)
                        .keyboardType(.default)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .background(GeometryReader { gp -> Color in
                            let rect = gp.frame(in: .named("OuterV")) // < in specific container
                            // let rect = gp.frame(in: .global) // < in window
                            // let rect = gp.frame(in: .local) // < own bounds
                            print("Origin: \(rect.origin)")
                            return Color.clear
                        })

                        //this does not work
                        .onTapGesture {
                        }

                    TextField("Placeholder", text: $someNumber2)
                        .keyboardType(.default)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
               }//group 1

               //bunch more

                Button(action: {
                    self.enteredNumber = self.someNumber1
                    self.someNumber1 = ""
//                    UIApplication.shared.endEditing()
                }) {
                    Text("Submit")
                }
                .padding(.bottom, 50)

            }//outer v
                .coordinateSpace(name: "OuterV") // << declare coord space
                .padding(.horizontal, 16)
                .padding(.top, 44)

        }//Scrollview or Form
//        .modifier(AdaptsToSoftwareKeyboard())
    }
}
```
