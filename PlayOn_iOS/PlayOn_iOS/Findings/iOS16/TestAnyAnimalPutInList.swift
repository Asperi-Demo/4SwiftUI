// 🔥BOYCOTT on russia - terrorist must be punished!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

#if canImport(Charts)
fileprivate protocol Animal: Hashable, Identifiable {
    var id: UUID { get }
    var name: String { get }
}

struct TestAnyAnimalPutInList: View {
    @State private var anAnimalID: UUID? // << here !!

    private let anAnimalList: [any Animal] = [Cow(name: "Aaron"), Chicken(name: "Billy"), Cow(name: "Charlie"), Chicken(name: "Delilah")]

    var body: some View {
        VStack {
            List(anAnimalList, id: \.id, selection: $anAnimalID) { animal in
                Text("Animal: \(animal.name)")
            }
            if let animal = anAnimalList.first { $0.id == anAnimalID } {
                Text("Animal is \(animal.name)")
            }
        }
    }
    
    struct Cow: Animal {
        let id = UUID()
        let name: String
    }
    
    struct Chicken: Animal {
        let id = UUID()
        let name: String
    }
}



struct TestAnyAnimalPutInList_Previews: PreviewProvider {
    static var previews: some View {
        TestAnyAnimalPutInList()
    }
}
#endif
