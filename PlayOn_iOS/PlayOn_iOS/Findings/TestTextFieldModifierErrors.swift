// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION:     By using this you agree do not repost any part of this code
//                    on StackOverflow site. Thanks, Asperi.

import SwiftUI

struct TestTextFieldModifierErrors: View {
    var body: some View {
        TestView()
    }
    
    struct TestView: View {
        @State private var text = ""
        
        var body: some View {
            TextField("Placeholder", text: $text)
                .modifier(TextFieldClearButton(text: $text))
        }
    }
    struct TextFieldClearButton: ViewModifier {
        
        @Binding var text: String
        
        func body(content: Content) -> some View {
            
            HStack {
                
                content
                
                if !text.isEmpty {
                    Button(
                        action: { self.text = "" },
                        label: {
                            Image(systemName: "delete.left")
                                .foregroundColor(Color(uiColor: UIColor.opaqueSeparator))
                        }
                    )
                }
            }
        }
    }
    
}

struct TestTextFieldModifierErrors_Previews: PreviewProvider {
    static var previews: some View {
        TestTextFieldModifierErrors()
    }
}
