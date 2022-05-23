```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: Passing An ObservedObject To Nested Child Views SwiftUI (SwiftUI Data Flow) (by Richard Witherspoon)

A: For `ObservableObject` the pairing `ObservedObject` makes view refresh, so to solve 
the task for class-based model the approach is to use own `ObservedObject` wrapper at each level
of navigation for corresponding sub-model, because `@Binding` might not work at deep navigation stack.

Demo

![EUxnl](https://user-images.githubusercontent.com/62171579/164610327-6b2e610a-bbb8-44a3-ac52-5fee23353fe2.gif)

Code

    import SwiftUI
    import Combine
    
    class Sport: ObservableObject, Hashable, Identifiable {
    
        static func == (lhs: Sport, rhs: Sport) -> Bool {
            lhs.name == rhs.name && lhs.isFavorite == rhs.isFavorite && lhs.school == rhs.school
        }
    
        func hash(into hasher: inout Hasher) {
            hasher.combine(name)
            hasher.combine(isFavorite)
            hasher.combine(school)
        }
    
        @Published var name : String
        @Published var isFavorite = false
        @Published var school : String
    
        init(name: String, isFavorite: Bool, school: String) {
            self.name = name
            self.isFavorite = isFavorite
            self.school = school
        }
    }
    
    final class SportData: ObservableObject  {
        @Published var store =
            [
                Sport(name: "soccer", isFavorite: false, school: "WPI"),
                Sport(name: "tennis", isFavorite: false, school: "WPI"),
                Sport(name: "swimming", isFavorite: true, school: "WPI"),
                Sport(name: "running", isFavorite: true, school: "RIT"),
        ]
    }
    
    struct TestingObservedObject: View {
        @ObservedObject var sports = SportData()
    
        var body: some View {
            NavigationView{
                List{
                    ForEach(sports.store){ sport in
                        NavigationLink(destination: ScreenTwo(sport: sport)) {
                            HStack {
                                Text("\(sport.name)")
                                Spacer()
                                Text(sport.isFavorite.description)
                            }
                        }
                        .onReceive(sport.$isFavorite) { _ in self.sports.objectWillChange.send() }
                    }
                }
            }.navigationBarTitle("Settings")
        }
    }
    
    struct ScreenTwo : View{
        @ObservedObject var sport : Sport
    
        var body: some View{
            NavigationLink(destination: DetailsView(sport: sport)){
                Text(sport.isFavorite.description)
            }
        }
    }
    
    struct DetailsView: View {
        @ObservedObject var sport : Sport
    
        var body: some View {
            Button(action: {
                self.sport.isFavorite.toggle()
                self.sport.name = "Ricky"
            }) {
                Text(sport.isFavorite.description)
                Text(sport.name)
            }
        }
    }
    
    
