```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: async operations using Combine and SwiftUI (by Ashley Mills)

A: I like having `result` as you did in second variant

    @Published var authorisationResult: Result<Bool, Error>?

so the possible approach for usage can be as follow

    NavigationLink(destination: NextView(), isActive: 
             Binding<Bool>.ifSuccess(self.healthKitManager.authorisationResult)) {
        Button("Show Next View") {
            self.healthKitManager.getHealthKitData(for: self.objectTypes)
        }
    }.navigationBarTitle("Content View")

where some convenient extension

    extension Binding {
        static func ifSuccess<E>(_ result: Result<Bool, E>?) -> Binding<Bool> where E: Error {
            Binding<Bool>(
                get: {
                    guard let result = result else { return false }
                    switch result {
                     case .success(true):
                        return true
                     default:
                        return false
                }
            }, set: { _ in })
        }
    }

the variant for `error` can be done in similar way.
