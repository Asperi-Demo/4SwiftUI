>
> 🔥BOYCOTT on russia - terrorist must be punished!<br>
> «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
> 
> ATTENTION: This is a demo - use it as you wish. Reference is appriciated.<br>
> If you want to thank - buy me coffee: [Coffee for Asperi](https://secure.wayforpay.com/donate/asperi)
>

Q: Why isn't my SwiftUI transition animating? (by Ferdz)

A: Here is possible solution - make views independent. Tested with Xcode 12 / iOS 14.

![LJXGj](https://user-images.githubusercontent.com/62171579/182015902-4fb3ab76-dba3-47d1-a314-1cf9bd51b9a1.gif)

```
struct RoomView: View {
    
    @State private var room: String?
    @State private var bookings: [String]?
    @State private var isLoading: Bool = false
    
    var body: some View {
        ZStack {
            if isLoading {
                // If we're loading
                ProgressView("Loading Room")
            }
            if let room = self.room {
                ScrollView {
                    LazyVStack(alignment: .leading) {
                        Text(room)
                        
                        if let bookings = bookings {
                            ForEach(bookings.indices) { (index) in
                                let booking = bookings[index]
                                VStack(alignment: .leading) {
                                    Text(booking)
                                    Divider()
                                }
                                .transition(.slide)
                                // Stagger the animations when displaying the list
                                .animation(Animation.spring().delay(0.04 * Double(index)))
                            }
                        }
                    }
                    .padding()
                }
            }
        }
        .transition(.opacity)
        .animation(.easeInOut)
        .onAppear {
            self.isLoading = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.room = "Demo room"
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    withAnimation {
                        self.bookings = ["Booking 1", "Booking 2", "Booking 3", "Booking 4", "Booking 5"]
                        self.isLoading = false
                    }
                }
            }
        }
    }
}
```
