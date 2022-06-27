```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
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

