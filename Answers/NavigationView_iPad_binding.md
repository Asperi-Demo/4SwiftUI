```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: SwiftUI NavigationLink pops automatically which is unexpected (by Thomas Vos)

A: Ok, here is my investigation results (tested with Xcode 11.2) and below is the code that works.

In iPad `NavigationView` got into Master/Details style, so `ContentView` having initial link is active and process bindings update from environmentObject, so refresh, which result in activating link of details view via same binding, thus corrupting navigation stack. (Note: this is absent in iPhone due to _stack_ style, which deactivates root view).

So, probably this is workaround, but works - the idea is not to pass binding from view to view, but use environmentObject directly in final view. Probably this will not always be a case, but anyway in such scenarios it is needed to avoid root view refresh, so it should not have same binding in body. Something like that.


    final class MyEnvironmentObject: ObservableObject {
        @Published var selection: Int? = nil
        @Published var isOn: Bool = false
    }
    
    struct ContentView: View {
        @EnvironmentObject var object: MyEnvironmentObject
    
        var body: some View {
            NavigationView {
                List {
                    NavigationLink("Go to FirstDestinationView", destination: FirstDestinationView())
                }
            }
        }
    }
    
    struct FirstDestinationView: View {
    
        var body: some View {
            List {
                NavigationLink("Go to SecondDestinationView", destination: SecondDestinationView())
            }
        }
    }
    
    struct SecondDestinationView: View {
    @EnvironmentObject var object: MyEnvironmentObject
    
        var body: some View {
            VStack {
                Toggle(isOn: $object.isOn) {
                    Text("Toggle")
                }
            }
        }
    }
