```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: Get Shape for view dynamically in SwiftUI (by Ryan Heitner)

A: Here are possible solutions. 

### Update: Tested with Xcode 13.4 / iOS 15.5

As on now IMO better to place all this model and use `ViewBuilder` then no any custom wrappers/erasures needed:


```
enum Suite {
  case heart, diamond, spade, club

  // Generate complete view and return opaque type
  @ViewBuilder
  var shape: some View {    // << here !!
     switch self {
        case .heart:
          Heart().fill(.red)    // or make it self.color
        case .diamond:
          Diamond().fill(.red)
        case .spade:
          Spade().fill(.black)
        case .club:
          Club().fill(.black)
    }
  }
}


struct CardView: View {
    let suit : Suite
    let rank : Rank

    var body: some View {
        suit.shape          // << as simple as !!
            .frame(width: 100, height: 100)
     }
}
```

### Original: Tested with Xcode 11.4.

```
struct CardView: View {
    let suit : Suite
    let rank : Rank
    var body: some View {
        // pass all dependencies to generate view
        getShape(suite: .heart, fill: suit.color) 
            .frame(width: 100, height: 100)
     }
}

// Generate complete view and return opaque type
func getShape(suite: Suite, fill color: Color) -> some View {
    switch suite {
        case .heart:
            return AnyView(Heart().fill(color))
        case .diamond:
            return AnyView(Diamond().fill(color))
        case .spade:
            return AnyView(Spade().fill(color))
        case .club:
            return AnyView(Club().fill(color))
   }
}
```
