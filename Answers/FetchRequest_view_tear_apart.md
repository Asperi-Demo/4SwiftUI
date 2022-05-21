```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: How to show sample data in PreviewProvider when using FetchRequest (by gurehbgui)

A: Here is possible approach, tested with Xcode 12 / iOS 14

The idea is to separate explicit view + model from model provider (in this case cloud database), 
so view could be designed & tested (previewed) having local or dynamically constructed mock 
model (not involving heavy cloud connection)

```
struct ReView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(
        entity: Re.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Re.name, ascending: false)
        ]
    ) var entities: FetchedResults<Re>
    
    var body: some View {
        ReEntitiesView(entities: entities)
    }
}

struct ReEntitiesView<Results:RandomAccessCollection>: View where Results.Element == Re {
    let entities: Results

    var body: some View {
        NavigationView {
            List(entities, id: \.self) { entity in
                Text(entity.name ?? "Unknown")
            }
        }
    }
}

struct ReView_Previews: PreviewProvider {
    static let entity = NSManagedObjectModel.mergedModel(from: nil)?.entitiesByName["Re"]

    static var previews: some View {
       let object = Re(entity: entity!, insertInto: nil)
       object.name = "Test Name"

       return ReEntitiesView(entities: [object])
   }
}
```
