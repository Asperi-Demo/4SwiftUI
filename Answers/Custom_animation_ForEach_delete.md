```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: SwiftUI custom list with ForEach delete animation not working (by )

A: We need to make each row uniquely identified, so animator knows 
what is added and what is removed and animates each change properly.

Here is possible approach. Tested with Xcode 12 / iOS 14

![FLsL7](https://user-images.githubusercontent.com/62171579/167589569-2a776c42-dbdd-4e2e-bf36-57d02ef86687.gif)

```
struct TimeItem: Identifiable, Equatable {
  static func == (lhs: Self, rhs: Self) -> Bool {
    lhs.id == rhs.id
  }

  let id = UUID()     // << identify item
  let minutes: Int
  let seconds: Int = 0
}

struct ContentView: View {
  @State var items = [TimeItem]()
  @State var selectedElement: TimeItem?

  var body: some View {
    ScrollView(){
      VStack{
        ForEach(items){ elem in   // << work by item

          ZStack{

            EntryBackground()


            Text("\(elem.minutes)")
              .transition(AnyTransition.scale)

            HStack{
              Button(action: {
                self.items.removeAll { $0.id == elem.id }
              })
              {
                Image(systemName: "minus.circle.fill")
                  .foregroundColor(Color.red)
                  .font(.system(size: 22))
                  .padding(.leading, 10)
              }
              Spacer()
            }

          }
          .padding(.horizontal)
          .padding(.top)
          .contentShape(Rectangle())
          .onTapGesture {
            withAnimation(.spring()){
              self.selectedElement = elem
            }
          }
        }
      }
      Spacer()

      Button(action: {
        self.items.append(TimeItem(minutes: self.items.count))
      })
      {
        ZStack{
          EntryBackground()

          Text("Add")

          HStack{
            Image(systemName: "plus.circle.fill")
              .foregroundColor(Color.green)
              .font(.system(size: 22))
              .padding(.leading, 10)

            Spacer()
          }
        }.padding()
      }
    }.animation(.spring(), value: items)   // << animate changes
  }
}

struct EntryBackground: View {
  var body: some View {
    Rectangle()
      .cornerRadius(12)
      .frame(height: 40)
      .foregroundColor(Color.gray.opacity(0.15))
  }
}
```
