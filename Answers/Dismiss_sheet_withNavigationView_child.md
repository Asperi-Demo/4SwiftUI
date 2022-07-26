```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: Dismiss a parent modal in SwiftUI from a NavigationView (by codewithfeeling)

A: Here is possible approach based on usage own explicitly created environment 
key (actually I have feeling that it is not correct to use `presentationMode` 
for this use-case.. anyway). 

Proposed approach is generic and works from any view in modal view hierarchy. 

Tested & works with Xcode 11.2 / iOS 13.2.

    // define env key to store our modal mode values
    struct ModalModeKey: EnvironmentKey {
        static let defaultValue = Binding<Bool>.constant(false) // < required
    }
    
    // define modalMode value
    extension EnvironmentValues {
        var modalMode: Binding<Bool> {
            get {
                return self[ModalModeKey.self]
            }
            set {
                self[ModalModeKey.self] = newValue
            }
        }
    }
    
    
    struct ParentModalTest: View {
      @State var showModal: Bool = false
    
      var body: some View {
        Button(action: {
          self.showModal.toggle()
        }) {
          Text("Launch Modal")
        }
        .sheet(isPresented: self.$showModal, onDismiss: {
        }) {
          PageOneContent()
            .environment(\.modalMode, self.$showModal) // < bind modalMode
        }
      }
    }
    
    struct PageOneContent: View {
      var body: some View {
        NavigationView {
          VStack {
            Text("I am Page One")
          }
          .navigationBarTitle("Page One")
          .navigationBarItems(
            trailing: NavigationLink(destination: PageTwoContent()) {
              Text("Next")
            })
          }
      }
    }
    
    struct PageTwoContent: View {
    
      @Environment (\.modalMode) var modalMode // << extract modalMode
    
      var body: some View {
        NavigationView {
          VStack {
            Text("This should dismiss the modal. But it just pops the NavigationView")
              .padding()
    
            Button(action: {
              self.modalMode.wrappedValue = false // << close modal
            }) {
              Text("Finish")
            }
            .padding()
            .foregroundColor(.white)
            .background(Color.blue)
          }
          .navigationBarTitle("Page Two")
        }
      }
    }

