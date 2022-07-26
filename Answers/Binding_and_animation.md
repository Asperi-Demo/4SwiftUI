```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: Animation not applied to SwiftUI view state change (by rustproofFish)

A: Here is possible approach - using animation applied to binding of modified state, (tested & works with Xcode 11.2 / iOS 13.2)

![Cd39f](https://user-images.githubusercontent.com/62171579/175861520-b480b15d-f6ca-4a3d-971d-482758d95ff9.gif)

    struct ContentView: View {
        @State private var isValid = true
    
        var body: some View {
            VStack {
                Form {
                    TextField("Placeholder", text: .constant(""))
                        .padding(6)
                        .background(ErrorView().opacity(isValid ? 0.0 : 1.0))
                        .overlay(RoundedRectangle(cornerRadius: 4)
                                .stroke(Color(.systemGray3), lineWidth: 1))
                        .padding()
    
                    Toggle(isOn: $isValid.animation(), label: { Text("Toggle Valid") })
                }
            }
        }
    }
    
    struct ErrorView: View {
    
        var body: some View {
            ZStack {
                HStack {
                    Spacer()
                    Image(systemName: "exclamationmark.triangle.fill")
                        .foregroundColor(Color.red)
                        .padding(.trailing, 8)
                }
    
                HStack {
                    Spacer()
                    Text("error message")
                        .font(.caption)
                        .foregroundColor(Color.red)
                        .offset(x: 0, y: -28)
                }
            }
        }
    }
