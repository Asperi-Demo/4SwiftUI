```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: Picker with SegmentPickerStyle() doesn’t show picker title in SwiftUI (by Ravindra_Bhati)

A: Label is not used for `SegmentedPickerStyle`. Instead you can use the following approach

![Lvk0w](https://user-images.githubusercontent.com/62171579/169584475-e72ddcf2-aa1a-42f1-9c09-b0b58e762f23.png)


    HStack {
        Text("Select Gender")    // << here !!
        Picker("", selection: $selectedGender) {
    
            ForEach(0..<genders.count) { index in
                Text(self.genders[index]).tag(index)
            }
        }.pickerStyle(SegmentedPickerStyle())
    }

