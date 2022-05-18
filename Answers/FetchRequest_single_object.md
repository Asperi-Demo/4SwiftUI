Q: swiftUI Core Data @FetchRequest single object (by georgeok)

A: We don't need @FetchRequest for that - instead can use existingObject(with objectID: NSManagedObjectID)... 
Assuming we have `Person` entity and somehow stored/get some id for some object, 
here is a demo of possible view that get that object by id and work with it

*Note: NSManagedObject conforms to ObservableObject*

```
struct DemoPersonView: View {
    @ObservedObject var person: Person

	init(id objectID: NSManagedObjectID, in context: NSManagedObjectContext) {
		if let person = try? context.existingObject(with: objectID) as? Person {
			self.person = person
		} else {
            // if there is no object with that id, create new one
			self.person = Person(context: context)
            try? context.save()
		}
	}
	
	var body: some View {
      VStack {
		Text("User: \(person.name ?? "<Unknown>")")

        // ... other possible code to manage/edit person
      }
	}
}
```

Tested with Xcode 12 / iOS 14
