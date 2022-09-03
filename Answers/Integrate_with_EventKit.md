>
> 🔥BOYCOTT on russia - terrorist must be punished!<br>
> «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
> 
> ATTENTION: This is a demo - use it as you wish. Reference is appriciated.<br>
> If you want to thank - buy me coffee: [Coffee for Asperi](https://secure.wayforpay.com/donate/asperi)
>

Q: SwiftUI EKEventEditViewController fields not editable (by user3752049)

A: Verified with Xcode 12 / iOS 14. A possible variant with added requestAccess (can be put in other place if needed) and make sure 
corresponding descriptions (`NSCalendarsUsageDescription`, `NSLocationWhenInUseUsageDescription`) added in `Info.plist`. 

![7x1a0](https://user-images.githubusercontent.com/62171579/188257371-e94ca7a6-bf78-4f07-8e64-d3477cb54924.gif)

Full tested module:

```
import SwiftUI
import EventKitUI

let eventStore = EKEventStore()

struct NewEventGenerator: UIViewControllerRepresentable {
    typealias UIViewControllerType = EKEventEditViewController

    @Binding var isShowing: Bool
    var theEvent: EKEvent

    init(isShowing: Binding<Bool>) {
        eventStore.requestAccess(to: .event) { allow, error in
            print("Result: \(allow) or [\(error.debugDescription)]")
        }

        theEvent = EKEvent.init(eventStore: eventStore)

        _isShowing = isShowing
    }


func makeUIViewController(context: UIViewControllerRepresentableContext<NewEventGenerator>) -> EKEventEditViewController {

    let controller = EKEventEditViewController()
    controller.event = theEvent
    controller.eventStore = eventStore
    controller.editViewDelegate = context.coordinator

    return controller
}

func updateUIViewController(_ uiViewController: NewEventGenerator.UIViewControllerType, context: UIViewControllerRepresentableContext<NewEventGenerator>) {
    uiViewController.view.backgroundColor = .red
}


func makeCoordinator() -> Coordinator {
    return Coordinator(isShowing: $isShowing)
}

class Coordinator : NSObject, UINavigationControllerDelegate, EKEventEditViewDelegate {

    @Binding var isVisible: Bool

    init(isShowing: Binding<Bool>) {
        _isVisible = isShowing
    }

    func eventEditViewController(_ controller: EKEventEditViewController, didCompleteWith action: EKEventEditViewAction) {
        switch action {
        case .canceled:
            isVisible = false
        case .saved:
            do {
                try controller.eventStore.save(controller.event!, span: .thisEvent, commit: true)
            }
            catch {
                print("Event couldn't be created")
            }
            isVisible = false
        case .deleted:
            isVisible = false
        @unknown default:
            isVisible = false
        }
    }
}}

struct TestEventKitViewInSheet: View {     // just created in ContentView body
    @State private var showIt = false
    var body: some View {
        Button("Events") { showIt = true }
            .sheet(isPresented: $showIt) {
                NewEventGenerator(isShowing: $showIt)
            }
    }
}
```
