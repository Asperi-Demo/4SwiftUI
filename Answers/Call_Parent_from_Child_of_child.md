```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: Call parent's function from child of a child in SwiftUI (by DevB2F)

A: It is possible to do using custom defined `EnvironmentKey` and then use it set parent view environment function, which will be available for all subviews.

Here is a demo of approach

    struct ParentFunctionKey: EnvironmentKey {
        static let defaultValue: (() -> Void)? = nil
    }
    
    extension EnvironmentValues {
        var parentFunction: (() -> Void)? {
            get { self[ParentFunctionKey.self] }
            set { self[ParentFunctionKey.self] = newValue }
        }
    }
    
    struct ParentView: View {
        func parentFunction() {
            print("parentFunction called")
        }
    
        var body: some View {
            VStack {
                ChildView()
            }
            .environment(\.parentFunction, parentFunction) // set in parent
        }
    }
    
    struct ChildView: View {
        @Environment(\.parentFunction) var parentFunction // join in child
        var body: some View {
            VStack {
                Text("child view")
                Button(action: {
                    self.parentFunction?() // < use in child
                }) {
                    Image(systemName: "person")
                }
                Divider()
                SubChildView()
            }
        }
    }
    
    struct SubChildView: View {
        @Environment(\.parentFunction) var parentFunction // join in next subchild
        var body: some View {
            VStack {
                Text("Subchild view")
                Button(action: {
                    self.parentFunction?() // use in next subchild
                }) {
                    Image(systemName: "person.2")
                }
            }
        }
    }

