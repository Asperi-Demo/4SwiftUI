```
🔥BOYCOTT on russia - terrorist must be punished!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: How to implement printer picker using SwiftUI? (by Abid Nawaz)

A: Here is possible approach - use representable. Tested & works with Xcode 11.4 / iOS 13.4

Note: make sure you activate *Printing* in project *Signing & Capabilities* settings.

I don't have AirPrint printers around, so ... just searching

![fbfmG](https://user-images.githubusercontent.com/62171579/177260198-fa87050c-bcf5-4387-90c2-d655e8f59784.gif)

Demo code:

    struct DemoPrinterPicker: View {
        @State private var showPicker = false
    
        var body: some View {
            Button("Select Printer") {
                self.showPicker.toggle()
            }
            .background(PrinterPickerController(showPrinterPicker: $showPicker))
        }
    }
    

SwiftUI representable (just shows printers picker, what to do with selected printer is your responsibility)

    struct PrinterPickerController: UIViewControllerRepresentable {
        @Binding var showPrinterPicker: Bool
    
        fileprivate let controller = UIViewController()
    
        func makeUIViewController(context: Context) -> UIViewController {
            controller
        }
    
        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
            if showPrinterPicker && context.coordinator.activePicker == nil {
                let picker = UIPrinterPickerController(initiallySelectedPrinter: nil)
                context.coordinator.activePicker = picker
    
                picker.delegate = context.coordinator
                picker.present(animated: true) { (picker, flag, error) in
                    if let printer =  picker.selectedPrinter {
                        // << do anything needed with printer
                    }
    
                    context.coordinator.activePicker = nil
                    self.showPrinterPicker = false
                }
            }
        }
    
        func makeCoordinator() -> Coordinator {
            Coordinator(self)
        }
    
        class Coordinator: NSObject, UIPrinterPickerControllerDelegate {
            let owner: PrinterPickerController
            var activePicker: UIPrinterPickerController?
    
            init(_ owner: PrinterPickerController) {
                self.owner = owner
            }
    
            func printerPickerControllerParentViewController(_ printerPickerController: UIPrinterPickerController) -> UIViewController? {
                self.owner.controller
            }
        }
        
        typealias UIViewControllerType = UIViewController
    }
