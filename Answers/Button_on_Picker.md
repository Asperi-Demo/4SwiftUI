>
> 🔥BOYCOTT on russia - terrorist must be punished!<br>
> «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
> 
> ATTENTION: This is a demo - use it as you wish. Reference is appriciated.<br>
> If you want to thank - buy me coffee: [Coffee for Asperi](https://secure.wayforpay.com/donate/asperi)
>

Q: Add button to picker label (by Ditza)

A: To solve this issue we need to separate picker and button and block Form tracking click inside row (which is by default track entire row).

For first move button out of picker and place everything in `HStack`, for second we need couple of tricks like tapGesture on label and non-default button style for button (for simplicity I used primitive button style, but it's better to create custom with appropriate highlight, etc.)

![RNRg9](https://user-images.githubusercontent.com/62171579/190661604-483134e5-0f1b-4261-a79b-38f464333220.gif)

Here is a simplified updated and tested your code (Xcode 13 / iOS 15):

```
  var body: some View {
    Form {
      Group {
        Section(header: Text("Animales")) {
          HStack{
            HStack {
              Text ("Chose Animale")
              Spacer ()
            }
            .contentShape(Rectangle())
            .onTapGesture {
                           // just blocker for label click
            }
            .overlay(
              Button (
                action: {
                  print ("clicked")
                },
                label: {
                  Image(systemName: "arrow.clockwise").foregroundColor(.blue)
                })
                .buttonStyle(PlainButtonStyle())   // << needed custom !!
            )
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .layoutPriority(1)     // << to cover much area
            //.border(Color.red)      // << for testing area

            Picker("",
                 selection: $selectedAnimal,
                 content: {
              ForEach(Animal.allCases, id:\.self) {
                Text($0.rawValue)
              }}
            )
              .labelsHidden()   // << hide own label
              .fixedSize()      // << limit size !!
          }
          .listRowInsets(EdgeInsets()) // << consume row space !!
        }
      }
    }
  }
```
