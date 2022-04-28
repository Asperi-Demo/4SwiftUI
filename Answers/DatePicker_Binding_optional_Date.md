```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: SwiftUI DatePicker Binding optional Date, valid nil (by wk.experimental)

A: The problem is that `DatePicker` grabs binding and is not so fast to release it 
even when we remove it from a view due to `Toggle` action, so it crashes when we force 
unwrap optional Binding, which becomes nil ...

A possible solution is to use dynamic not-optional Binding which provides non-optional
value as well.

**IMPORTANT: Never force unwrap!!!**

The solution for this crash is

    DatePicker("Due Date",
        selection: Binding<Date>(get: {self.testDate ?? Date()}, set: {self.testDate = $0}),
        displayedComponents: .date
    )

