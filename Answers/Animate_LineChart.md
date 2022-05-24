Q: Swiftui animate each line while drawing a line graph using path (by bluesman)

```
struct ChartItem: Identifiable{
    let id = UUID()
    var y: Float
    var x: Float
    
}

struct LineChartShape: Shape {
    
    var chartItems: [ChartItem]

    var animatableData: [ChartItem] {
        get { chartItems }
        set {
            self.chartItems = newValue
        }
    }

    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.width
        let height = rect.height
        path.move(to: CGPoint(x: width * 0.05, y: height * 0.5))
        
        chartItems.forEach { chartItem in
            path.addLine(to: CGPoint(x: width * CGFloat(chartItem.x), y:  height * CGFloat(chartItem.y)))
        }
        
        return path
    }
}
```

A: Here is a demo of possible solution. Tested with Xcode 12.

![5Cn1e](https://user-images.githubusercontent.com/62171579/169962307-303ef713-3417-4527-9ad4-2a1ed0570773.gif)

```
struct TestAnimateAddShape: View {
    @State private var end = CGFloat.zero
    var body: some View {
        GeometryReader { geometry in

            LineChartShape(chartItems: [
                ChartItem(y: 0.5, x: 0.05),
                ChartItem(y: 0.4, x: 0.1),
                ChartItem(y: 0.2, x: 0.15),
                ChartItem(y: 0.3, x: 0.2),
                ChartItem(y: 0.3, x: 0.25),
                ChartItem(y: 0.4, x: 0.3),
                ChartItem(y: 0.5, x: 0.35),
                ChartItem(y: 0.3, x: 0.4),
                ChartItem(y: 0.6, x: 0.45),
                ChartItem(y: 0.65, x: 0.5),
                ChartItem(y: 0.5, x: 0.55),
                ChartItem(y: 0.5, x: 0.6),
                ChartItem(y: 0.4, x: 0.65),
                ChartItem(y: 0.45, x: 0.7),
                ChartItem(y: 0.3, x: 0.75),
                ChartItem(y: 0.3, x: 0.8),
                ChartItem(y: 0.2, x: 0.85),
                ChartItem(y: 0.3, x: 0.9)
            ])
                .trim(from: 0, to: end)            // << here !!
                .stroke(Color.blue, lineWidth: 5)
                .animation(.easeInOut(duration: 10), value: end)
        }.onAppear { self.end = 1 }                  // << activate !!
    }
}
```
