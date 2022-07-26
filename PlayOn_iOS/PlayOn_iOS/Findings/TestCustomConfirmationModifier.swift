// 🔥BOYCOTT on russia - terrorist must be punished!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestCustomConfirmationModifier: View {
    
    @State private var showConfirmationDialog = false
    @State private var showModifierDialog = false
    
    var body: some View {
        VStack {
            Button("Show Dialog") { showConfirmationDialog = true }
            Button("Show ViewMod Dialog") {
                withAnimation {
                    showModifierDialog = true
                }
            }
            .padding()
        }
        .padding()
        
        // standard confirmationDialog
        .confirmationDialog("Test", isPresented: $showConfirmationDialog) {
            Button { } label: {
                Label("Add completion", systemImage: "checkmark.circle")
            }
            Button { } label: {
                Label("Add Note", systemImage: "note.text.badge.plus")
            }
            Button("Cancel", role: .cancel) {}
        }
        
        // custom confirmationDialog with Icons, Cancel added automatically
        .customConfirmDialog(isPresented: $showModifierDialog) {
            Button {
                // action
                showModifierDialog = false
            } label: {
                Label("Add completion", systemImage: "checkmark.circle")
            }
            Button {
                // action
                showModifierDialog = false
            } label: {
                Label("Add Note", systemImage: "note.text.badge.plus")
            }
        }
    }
}

extension View {
    func customConfirmDialog<A: View, B: View>(isPresented: Binding<Bool>, @ViewBuilder actions: @escaping () -> TupleView<(A, B)>) -> some View {
        return self.modifier(MyCustomModifier(isPresented: isPresented, actions: {
            let buttons = actions()
            VStack(alignment: .leading) {
                buttons.value.0
                Divider()
                buttons.value.1
            }
        }))
    }
}

struct MyCustomModifier<A>: ViewModifier where A: View {
    
    @Binding var isPresented: Bool
    @ViewBuilder let actions: () -> A
    
    func body(content: Content) -> some View {
        ZStack {
            content
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            ZStack(alignment: .bottom) {
                if isPresented {
                    Color.primary.opacity(0.2)
                        .ignoresSafeArea()
                        .onTapGesture {
                                isPresented = false
                        }
                        .transition(.opacity)
                }
                
                if isPresented {
                    VStack {
                        GroupBox {
                            actions()
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        
                        GroupBox {
                            Button("Cancel", role: .cancel) {
                                    isPresented = false
                            }
                            .frame(maxWidth: .infinity, alignment: .center)
                        }
                    }
                    .font(.title3)
                    .padding(8)
                    .transition(.move(edge: .bottom))
                }
            }
        }
        .animation(.easeInOut, value: isPresented)
   }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        TestCustomConfirmationModifier()
    }
}
