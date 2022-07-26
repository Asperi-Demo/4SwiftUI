```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: Dynamically change and update color of Navigation Bar in SwiftUI (by swiftyboy01)

A: Yes, appearance is applied to all views *created after* appearance itself. So we need to reset appearance and then create `NavigationView` again on color changes.

Here is a demo of possible approach (tested with Xcode 13 / iOS 15)

![WSVo7](https://user-images.githubusercontent.com/62171579/171559527-ab0354bf-b499-452b-8894-6697f4b4d7c9.gif)

```
struct ContentView: View {
  @State var color: Color = .red

  var body: some View {
    MainNavView(barColor: $color)
      .id(color)                // << re-creates !!
  }
}

struct MainNavView: View {
  @Binding var color: Color
  init(barColor: Binding<Color>) {
    self._color = barColor
    let navbarAppearance = UINavigationBarAppearance()
    navbarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
    navbarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
    navbarAppearance.backgroundColor = UIColor(color)
    UINavigationBar.appearance().standardAppearance = navbarAppearance
    UINavigationBar.appearance().compactAppearance = navbarAppearance
    UINavigationBar.appearance().scrollEdgeAppearance = navbarAppearance

  }

  var body: some View {
    NavigationView {
      VStack(spacing: 20) {
        Button(action: { color = .blue }) {
          Text("Blue")
            .font(.title)
            .bold()
            .foregroundColor(.white)
            .frame(width: 100)
            .padding()
            .background(Color.blue)
            .cornerRadius(15)
        }
        Button(action: { color = .red }) {
          Text("Red")
            .font(.title)
            .bold()
            .foregroundColor(.white)
            .frame(width: 100)
            .padding()
            .background(Color.red)
            .cornerRadius(15)
        }
      }
      .offset(y: -50)
      .navigationTitle("My Navigation")
    }
  }
}
```
