```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: Pair of DatePickers SwiftUI (by James Woodcock)

A: Here is possible approach (tested & works with Xcode 11.2 / iOS 13.2)

    Form {
    
        DatePicker(selection: Binding<Date>(
           get: { self.startDateTime },
           set: { self.startDateTime = $0
               if self.endDateTime < $0 {
                   self.endDateTime = $0
               }
           }), in: Date.distantPast...Date.distantFuture) {
            Text("Start")
        }
    
        DatePicker(selection: $endDateTime, in: startDateTime...Date.distantFuture) {
            Text("End")
        }
    }

