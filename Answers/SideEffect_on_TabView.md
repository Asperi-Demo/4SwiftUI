>
> 🔥BOYCOTT on russia - terrorist must be punished!<br>
> «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
> 
> ATTENTION: This is a demo - use it as you wish. Reference is appriciated.<br>
> If you want to thank - buy me coffee: [Coffee for Asperi](https://secure.wayforpay.com/donate/asperi)
>

Q: SwiftUI TabView how can I load more data on 2nd tab click (by user1591668)

A: For this scenario the solution is to use proxy binding (to intercept every click) as was 
shown in second link from referenced question.

Tested with Xcode 13 / iOS 15

![9Ak5Q](https://user-images.githubusercontent.com/62171579/190660633-9e24979c-bf6e-4576-9714-11129aeafa16.gif)

```
struct TabViews: View {
  @State var selectedTab: Tab = .MainView
  @State private var firstPass = false

  private var selection: Binding<Tab> { Binding(  // << this !!
    get: { selectedTab },
    set: {
      selectedTab = $0

      print("Tapped!! \(selectedTab)")


      if $0 == .MainView  {

        if firstPass == true {
          // update list
          print("Update get more data")

          firstPass = false  // << reset !!
          return
        }
        firstPass = true
      }
      if $0 == .MenuView {
        print("2")
        firstPass = false
      }
    }
  )}

  var body: some View {
    TabView(selection: selection) {    // << here !!
      Text("Main View")
        .padding()
        .tabItem {
          Image(systemName: "1.circle")
          Text("First")
        }
        .tag(Tab.MainView)

      Text("Menu View")
        .padding()
        .tabItem {
          Image(systemName: "2.circle")
          Text("Second")
        }
        .tag(Tab.MenuView)
    }
  }
}
```
