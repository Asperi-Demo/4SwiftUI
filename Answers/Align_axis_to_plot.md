>
> 🔥BOYCOTT on russia - terrorist must be punished!<br>
> «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
> 
> ATTENTION: This is a demo - use it as you wish. Reference is appriciated.<br>
> If you want to thank - buy me coffee: [Coffee for Asperi](https://secure.wayforpay.com/donate/asperi)
>

Q: Aligning HStack without equal sizing in SwiftUI (by Robert Gummesson)

A: Today I would do it with the following approach...

Result demo

![qvYc0](https://user-images.githubusercontent.com/62171579/183703459-0d4950d6-b80c-4e50-b256-0123c9118e35.png)

Code (`TopChartAndMidTitle` used from original question "as is")

    struct TestAlignScales: View {
        var labels = ["1900", "1800", "1700", "1600", "1500", "1400"]
    
        @State private var graphHeight = CGFloat.zero
        var body: some View {
            HStack(alignment: .topChartAndMidTitle) {
                Rectangle().fill(Color.red)
                    .alignmentGuide(.topChartAndMidTitle) { d in
                        if self.graphHeight != d.height {
                            self.graphHeight = d.height
                        }
                        return d[.top]
                    }
                valueLabels()
            }
        }
    
        @State private var delta = CGFloat.zero
        private func valueLabels() -> some View {
            VStack {
                ForEach(labels, id: \.self) { label in
                    VStack {
                        if label == self.labels.first! {
                            Text(label).font(.footnote)
                                .alignmentGuide(.topChartAndMidTitle) { d in
                                    if self.delta != d.height {
                                        self.delta = d.height
                                    }
                                    return d[VerticalAlignment.center]
                                }
                        } else {
                            Text(label).font(.footnote)
                        }
                        if label != self.labels.last! {
                            Spacer()
                        }
                    }
                }
            }
            .frame(height: graphHeight + delta)
        }
    
    }
    
    struct TestAlignScales_Previews: PreviewProvider {
        static var previews: some View {
            TestAlignScales()
                .frame(height: 400)
        }
    }

