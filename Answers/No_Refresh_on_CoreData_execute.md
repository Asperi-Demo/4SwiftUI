```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: List does not update automatically after deleting all Core Data Entity entries (by )

A: The reason is that `execute` (as described in details below - pay attention on first sentence) does not affect managed objects context, so all fetched objects remains in context and UI represents what is really presented by context.

So in general, after this bulk operation you need to inform back to that code (not provided here) force sync and refetch everything.

API interface declaration

>     // Method to pass a request to the store without affecting the contents of the managed object context.
>     // Will return an NSPersistentStoreResult which may contain additional information about the result of the action
>     // (ie a batch update result may contain the object IDs of the objects that were modified during the update).
>     // A request may succeed in some stores and fail in others. In this case, the error will contain information
>     // about each individual store failure.
>     // Will always reject NSSaveChangesRequests.
>     @available(iOS 8.0, *)
>     open func execute(_ request: NSPersistentStoreRequest) throws -> NSPersistentStoreResult


For example it might be the following approach (scratchy)

    // somewhere in View declaration
    @State private var refreshingID = UUID()

    ...
    // somewhere in presenting fetch results
    ForEach(fetchedResults) { item in
        ...
    }.id(refreshingID) // < unique id of fetched results

    ...

    // somewhere in bulk delete 
    try context.save() // < better to save everything pending
    try context.execute(deleteRequest)
    context.reset() // < reset context
    self.refreshingID = UUID() // < force refresh
