```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: Is there a way to modify fetched results with a predicate after they are initialized? (by Jannis)

A: > Is there a way to modify fetched results with a predicate after they
> are initialized?

Well... no, not in the way you try to do this, and even if you'd try to create it with NSFetchRequest instance, which is reference, and allows to change predicate later, that wouldn't work, because SwiftUI's FetchRequest stores copy of provided fetch request (or creates own with provided parameters)... so, no. But...

You can break apart view providing fetch request parameters with view constructing fetch request and showing result.

Here is a demo of approach (important part of it) which gives you possibility to get results with different dynamically changed predicates:


    struct MasterView: View {
        @State var predicate: NSPredicate? = nil
        var body: some View {
            VStack {
                Button(action: { // button just for demo
                    self.predicate = NSPredicate(format: "title contains[c] %@", "h")
                }, label: { Text("Filter") })
                ResultView(predicate: self.predicate)
            }
        }
    }
    
    struct ResultView: View {
    
        @FetchRequest
        var events: FetchedResults<Event>
    
        @Environment(\.managedObjectContext)
        var viewContext
    
        init(predicate: NSPredicate?) {
            let request: NSFetchRequest<Event> = Event.fetchRequest()
            request.sortDescriptors = [NSSortDescriptor(keyPath: \Event.timestamp, ascending: true)]
            if let predicate = predicate {
                request.predicate = predicate
            }
            _events = FetchRequest<Event>(fetchRequest: request)
        }
        
        var body: some View {
            List {
                ForEach(events, id: \.self) { event in
        ...

