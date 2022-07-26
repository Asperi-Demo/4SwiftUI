```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: Passing Core Data FetchedResults<T> for previews in SwiftUI (by andrw)
  
A: As `FetchedResults<T>` is a `RandomAccessCollection` and swift array also is a `RandomAccessCollection`, 
here is possible solution - use a generic `PersonsView` where collection can be injected and so preview
a view without inserting new objects into database.

## Update: verified with Xcode 13.3 / iOS 15.4

```
struct ContentView: View {
    @Environment(\.managedObjectContext) var context
    @FetchRequest(entity: Person.entity(), sortDescriptors: [])
        var result: FetchedResults<Person>

    var body: some View {
        VStack(alignment: .leading) {
            Text("Persons").font(.title)
            PersonsView(results: result) // FetchedResults<Person> is a collection
        }
    }
}

// generalize PersonsView to depend just on collection
struct PersonsView<Results:RandomAccessCollection>: View where Results.Element == Person {
    let results: Results
    var body: some View {
        ForEach(results, id: \.self) { person in
            Text("Name: \(person.name ?? "<unknown>")")
        }
    }
}

// Tested with Xcode 11.4 / iOS 13.4
// DOES NOT WORK ANYMORE !!
// struct ChildView_Previews: PreviewProvider {
//    static var previews: some View {
//        PersonsView(results: [Person()]) // << use regular array //to test
//    }
}
```

**Update:** fixed & tested part for Xcode 12 / iSO 14 (due to crash of above PreviewProvider)

It appears entity now should be read & specified explicitly:

```
struct ChildView_Previews: PreviewProvider {
    static let entity = NSManagedObjectModel.mergedModel(from: nil)?.entitiesByName["Person"]

    static var previews: some View {
        let person = Person(entity: entity!, insertInto: nil)
        person.name = "Test Name"

        return PersonsView(results: [person])
    }
}
```
