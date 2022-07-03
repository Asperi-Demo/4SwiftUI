```
🔥BOYCOTT on russia - terrorist must be punished!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: Binding in SwiftUI fails to work inside of a loop (by strangetimes)

A: It is due to **statically_ranged_ForEach**... as I experienced here on SO it is most confused concept in SwiftUI.. anyway - the solution is to use dynamic container of explicit models for sections. 

Here is simplified working demo of your code (but the idea should be easily adoptable to your not provided components).

Tested with Xcode 11.4 / iOS 13.4

![go9SI](https://user-images.githubusercontent.com/62171579/177030404-7716870d-0339-4101-8733-a82550cfdc87.gif)

```
// simple demo model for sections
struct SectionModel: Identifiable {
    let id: Int
    var expanded = true
}

struct TestCollapsableListView: View {
  // dynamic container with model, state is triggered
  @State var sections = [SectionModel(id: 0), SectionModel(id: 1), SectionModel(id: 2)]

  var body: some View {
    VStack {
      List {
        ForEach(sections) { section in
          Section(header: Button("Section \(section.id)") { self.sections[section.id].expanded.toggle() }) {
            if section.expanded {
              ForEach(0..<10) { item in
                Text("\(item) is \(section.expanded ? "Expanded" : "Collapsed")")
                  .frame(height: section.expanded ? 10 : 10)
              }
            }
          }
        }
      }
    }
  }
}
```
