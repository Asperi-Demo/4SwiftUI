```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: DragGesture on a VStack with lot of Buttons, how to detect when the drag is inside a Button (by inatreecrown)

A: Ok, it is a bit a lot of code, so I simplified it as much as possible just to demo possible approach (w/o frame overlapping, dragging relocation, floating drag item, etc.). Moreover it is not clear from the question for what it will be used. Anyway, hope this demo will be useful somehow. 

*Note:* used Xcode 11.2

Here is the result

![0oezL](https://user-images.githubusercontent.com/62171579/167286528-11f74d81-e276-4951-9e1e-de5661cc3a84.gif)

Here is one module demo code

    struct DestinationDataKey: PreferenceKey {
        typealias Value = [DestinationData]
    
        static var defaultValue: [DestinationData] = []
        
        static func reduce(value: inout [DestinationData], nextValue: () -> [DestinationData]) {
            value.append(contentsOf: nextValue())
        }
    }
    
    struct DestinationData: Equatable {
        let destination: Int
        let frame: CGRect
    }
    
    struct DestinationDataSetter: View {
        let destination: Int
        
        var body: some View {
            GeometryReader { geometry in
                Rectangle()
                    .fill(Color.clear)
                    .preference(key: DestinationDataKey.self,
                                value: [DestinationData(destination: self.destination, frame: geometry.frame(in: .global))])
            }
        }
    }
    
    struct DestinationView: View {
        @Binding var active: Int
        let label: String
        let id: Int
        
        var body: some View {
            Button(action: {}, label: {
                Text(label).padding(10).background(self.active == id ? Color.red : Color.green)
            })
            .background(DestinationDataSetter(destination: id))
        }
    }
    
    struct TestDragging: View {
        @State var active = 0
        @State var destinations: [Int: CGRect] = [:]
        
        var body: some View {
            VStack {
                Text("Drag From Here").padding().background(Color.yellow)
                    .gesture(DragGesture(minimumDistance: 0.1, coordinateSpace: .global)
                        .onChanged { value in
                            self.active = 0
                            for (id, frame) in self.destinations {
                                if frame.contains(value.location) {
                                    self.active = id
                                }
                            }
                        }
                        .onEnded { value in
                            // do something on drop
                            self.active = 0
                        }
                )
                Divider()
                DestinationView(active: $active, label: "Drag Over Me", id: 1)
            }.onPreferenceChange(DestinationDataKey.self) { preferences in
                for p in preferences {
                    self.destinations[p.destination] = p.frame
                }
            }
        }
    }
