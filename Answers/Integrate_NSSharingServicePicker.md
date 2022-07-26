```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: SwiftUI using NSSharingServicePicker in MacOS (by davidev)

A: As in many other cases to use different system APIs from SwiftUI we should
use platform representable wrapper, but due to different event-cycle of AppKit
and SwiftUI there are specifics - see comments inline.

Here is minimal working demo example

![ARTbo](https://user-images.githubusercontent.com/62171579/165330800-974d578e-7df0-4ecd-9fc1-0ca9e862c5a4.gif)


    struct SharingsPicker: NSViewRepresentable {
        @Binding var isPresented: Bool
        var sharingItems: [Any] = []
    
        func makeNSView(context: Context) -> NSView {
            let view = NSView()
            return view
        }
    
        func updateNSView(_ nsView: NSView, context: Context) {
            if isPresented {
                let picker = NSSharingServicePicker(items: sharingItems)
                picker.delegate = context.coordinator

                // !! MUST BE CALLED IN ASYNC, otherwise blocks update
                DispatchQueue.main.async {
                    picker.show(relativeTo: .zero, of: nsView, preferredEdge: .minY)
                }
            }
        }
    
        func makeCoordinator() -> Coordinator {
            Coordinator(owner: self)
        }
    
        class Coordinator: NSObject, NSSharingServicePickerDelegate {
            let owner: SharingsPicker
    
            init(owner: SharingsPicker) {
                self.owner = owner
            }
    
            func sharingServicePicker(_ sharingServicePicker: NSSharingServicePicker, didChoose service: NSSharingService?) {
    
                // do here whatever more needed here with selected service
    
                sharingServicePicker.delegate = nil   // << cleanup
                self.owner.isPresented = false        // << dismiss
            }
        }
    }
    

Demo of usage:


    struct TestSharingService: View {
        @State private var showPicker = false
        var body: some View {
            Button("Share") {
                self.showPicker = true
            }
            .background(SharingsPicker(isPresented: $showPicker, sharingItems: ["Message"]))
        }
    }

