```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: SwiftUI: How to drag and drop a contact from Contacts on macOS (by iphaaw)

A: The subscription & load data types should be the same, so here is a demo of worked solution. Tested with Xcode 12.1 / macOS 10.15.7

```
let uttypes = [String(kUTTypeVCard), String(kUTTypeEmailMessage)]

struct ContentView: View
{
    let dropDelegate = ContactDropDelegate()

    var body: some View
    {
        VStack
        {
            Text("Drag your contact here!")
            .padding(20)
        }
        .onDrop(of: uttypes, delegate: dropDelegate) // << kUTTypeVCard !!
    }
}

import Contacts

struct ContactDropDelegate: DropDelegate
{

    func validateDrop(info: DropInfo) -> Bool
    {
        return true
    }
    
    func dropEntered(info: DropInfo)
    {
        print ("Drop Entered")
    }
    
    func performDrop(info: DropInfo) -> Bool
    {
        print ("performDrop")
        NSSound(named: "Submarine")?.play()
        
        print (info)
        print ("Has UniformTypeIdentifiers:", info.hasItemsConforming(to: uttypes))
        
        let items = info.itemProviders(for: uttypes)
        print ("Number of items:",items.count)
        print (items)

        for item in items
        {
            item.loadDataRepresentation(forTypeIdentifier: kUTTypeVCard as String, completionHandler: { (data, error) in
                if let data = data, 
                   let contact = try? CNContactVCardSerialization.contacts(with: data).first
                {
                    print("Contact: \(contact.givenName)")
                }
            })
         }
        return true
    }
}
```
