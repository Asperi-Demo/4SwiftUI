// 🔥BOYCOTT on russia - terrorist must be punished!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestAssingEnumKeypath: View {
    class Sample: ObservableObject {
        
        @Published var enum1: Enum1 = .main
        @Published var enum2: Enum2 = .foo
        @Published var enum3: Enum3 = .add
        
        enum Enum1 {
            case main
            case test
        }
        
        enum Enum2 {
            case foo
            case blah
        }
        
        enum Enum3 {
            case add
            case remove
        }
    }
    
    struct MultipleUseView<T>: View {
        @EnvironmentObject var sample: Sample
        
        var `enum`: ReferenceWritableKeyPath<Sample, T>
        var destination: T
        
        var body: some View {
            Button {
                sample[keyPath: `enum`] = destination
            } label: {
                Text("Tap Me")
            }
        }
    }
    
    @EnvironmentObject var sample: Sample
    
    var body: some View {
        MultipleUseView(enum: \.enum1, destination: .main)
    }
}

struct TestAssingEnumKeypath_Previews: PreviewProvider {
    static var previews: some View {
        TestAssingEnumKeypath()
    }
}
