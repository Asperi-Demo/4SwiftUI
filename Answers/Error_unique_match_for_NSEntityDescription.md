```
BOYCOTT on ᵣussia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: Failed to find a unique match for an NSEntityDescription to a managed object subclass (by Clément Tengip)

A: It is loaded model several times - that's the reason of those errors. Possible solution is to make container static.

Tested with Xcode 12.1 / iOS 14.1 - no errors:

```
class OriEPS {
    
    
   private static var persistentContainer: NSPersistentContainer = {
            let container = NSPersistentContainer(name: "CDOriEPS")
            container.loadPersistentStores { description, error in
                if let error = error {
                     fatalError("Unable to load persistent stores: \(error)")
                }
            }
            return container
        }()
    
    var context: NSManagedObjectContext {
        return Self.persistentContainer.viewContext
    }

    // ... other code
```

*Note: other possible approach is to make `OriEPS` shared and use same instance everywhere you create it, but I did not investigate your solution deeply, so it is for your consideration.*
