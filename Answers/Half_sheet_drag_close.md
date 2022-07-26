```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: Switching a @State property to a @Binding property interferes with animation (by Flerex)

A: Actually I see here some misunderstanding that must be clarified and, probably, then initial solution should be rethink. Binding is not *state shared to parent*, it is link to parent's state holding source of truth, so your view becomes dependent on parent's capability to refresh it on state change, which is not always reliable (or stable, or persistent, etc.), especially in different view hierarchies (like, sheets, UIKit backend, etc.). Changing binding you do not refresh your view directly (as opposite to changes own state) even if your view depends on value in binding, but change parent state, which might do or might do not update your view back. Finalizing - what you've implied is not reliable approach by nature, and you actually observe this. 

*Alternate solution:* use `ObsevableObject/ObservedObject` view model pattern.

Tested with Xcode 12.4 / iOS 14.4

![FrQXN](https://user-images.githubusercontent.com/62171579/170528973-e09326aa-8058-49cb-96f2-8ac1e31b9a0b.gif)

```
import MapKit

class ReleaseGestureVM: ObservableObject {
	@Published var opened: Bool = false
}

struct ReleaseGesture<Header: View, Content: View>: View {

    // MARK: Init properties
	@ObservedObject var vm: ReleaseGestureVM

    // Height of the provided header view
    let headerHeight: CGFloat

    // Height of the provided content view
    let contentHeight: CGFloat

    // The spacing between the header and the content
    let separation: CGFloat

    let header: () -> Header
    let content: () -> Content


    // MARK: State
    @GestureState private var translation: CGFloat = 0


    // MARK: Constants
    let capsuleHeight: CGFloat = 5
    let capsulePadding: CGFloat = 5


    // MARK: Computed properties

    // The current static value that is always taken into account to compute the sheet's position
    private var offset: CGFloat {
        self.vm.opened ? self.headerHeight + self.contentHeight : self.headerHeight
    }

    // Gesture used for the snap animation
    private var gesture: some Gesture {
        DragGesture()
            .updating(self.$translation) { value, state, transaction in
                state = -value.translation.height
            }
            .onEnded {_ in
                self.vm.opened.toggle()
            }
    }

    // Animation used when the drag stops
    private var animation: Animation {
        .spring(response: 0.3, dampingFraction: 0.75, blendDuration: 1.5)
    }


    // Drag indicator used to indicate the user can drag the sheet
    private var dragIndicator: some View {
        Capsule()
            .fill(Color.gray.opacity(0.4))
            .frame(width: 40, height: capsuleHeight)
            .padding(.vertical, self.capsulePadding)
    }

    var body: some View {

        GeometryReader { reader in


            VStack(spacing: 0) {
                VStack(spacing: 0) {
                    self.dragIndicator
                    VStack(content: header)
                        .padding(.bottom, self.separation)
                    VStack(content: content)
                }
                .padding(.horizontal, 10)


            }
            // Frame is three times the height to avoid showing the bottom part of the sheet if the user scrolls a lot when the total height turns out to be the maximum height of the screen and is also opened.
            .frame(width: reader.size.width, height: reader.size.height * 3, alignment: .top)
            .background(Color.white.opacity(0.8))
            .cornerRadius(10)
            .offset(y: reader.size.height - max(self.translation + self.offset, 0))
            .animation(self.animation, value: self.offset)
            .gesture(self.gesture)

        }
        .clipped()
    }


    // MARK: Initializer
    init(
        vm: ReleaseGestureVM,
        headerHeight: CGFloat,
        contentHeight: CGFloat,
        separation: CGFloat,
        @ViewBuilder header: @escaping () -> Header,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.vm = vm
        self.headerHeight = headerHeight + self.capsuleHeight + self.capsulePadding * 2 + separation
        self.contentHeight = contentHeight
        self.separation = separation
        self.header = header
        self.content = content
    }
}

struct ReleaseGesture_Previews: PreviewProvider {

    struct WrapperView: View {

        @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))

        @StateObject private var vm = ReleaseGestureVM()

        var body: some View {
            ZStack {
                Map(coordinateRegion: $region)
                ReleaseGesture(
                    vm: self.vm,
                    headerHeight: 25,
                    contentHeight: 300,
                    separation: 30,
                    header: {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.black.opacity(0.3))
                            .frame(height: 30)
                    },
                    content: {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.orange.opacity(0.2))
                            .frame(width: 300, height: 300)

                    }
                )
            }
            .ignoresSafeArea()

        }
    }

    static var previews: some View {
        WrapperView()
    }
}
```
