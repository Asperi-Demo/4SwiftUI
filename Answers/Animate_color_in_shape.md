>
> 🔥BOYCOTT on russia - terrorist must be punished!<br>
> «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
> 
> ATTENTION: This is a demo - use it as you wish. Reference is appriciated.<br>
> If you want to thank - buy me coffee: [Coffee for Asperi](https://secure.wayforpay.com/donate/asperi)
>

Q: SwiftUI Animated Shape going crazy (by cdeerinck)

A: We need to separate *model* from *view model*, because to have `PolyShape` correctly work in your case the input data have to be a value.

Here is tested solution (Xcode 12 / iOS 14)

![wKMq8](https://user-images.githubusercontent.com/62171579/182543229-aa1a6e53-47ff-48ce-9d4d-8f0470c3fb2e.gif)

1) Separate model and view model

```
class Poly: ObservableObject, Identifiable {
    @Published var data:PolyData

    init(data: PolyData) {
		self.data = data
    }
}

struct PolyData {
    var location:CGPoint
    var color:Color

    var sides:CGFloat
    var vertexRadius:CGFloat
    var angle:CGFloat

    init(at:CGPoint, color:Color, sides:CGFloat, radius:CGFloat, angle:CGFloat=0) {
        self.location = at
        self.color = color
        self.sides = sides
        self.vertexRadius = radius
        self.angle = angle
    }
}
```

2. Make shape value dependent

```
struct PolyShape:Shape {

    var poly:PolyData      // << here !!

    public var animatableData: AnimatablePair<CGFloat, AnimatablePair<CGFloat,CGFloat>>  {
        get { AnimatablePair(poly.angle, AnimatablePair(poly.location.x, poly.location.y))
        }
        set {
            poly.angle = newValue.first
            poly.location.x = newValue.second.first
            poly.location.y = newValue.second.second
        }
    }

    func path(in rect: CGRect) -> Path {

        var path = Path()
        var radial:CGFloat = 0.5

        while radial < twoPi + 0.5 {
            let radialAngle = twoPi / poly.sides * radial + poly.angle
            let newX = poly.location.x + cos(radialAngle) * poly.vertexRadius
            let newY = poly.location.y + sin(radialAngle) * poly.vertexRadius
            if radial == 0.5 {
                path.move(to: CGPoint(x: newX, y: newY))
            } else {
                path.addLine(to: CGPoint(x: newX, y: newY))
            }
            radial += 1
        }
        return path
    }
}
```

3. Update dependent demo

```
struct ContentView: View {

    @ObservedObject var poly:Poly = Poly(data: PolyData(at: CGPoint(x:200,y:200), color: .green, sides: 6, radius: 100))
    
    var body: some View {

        PolyShape(poly: poly.data)     // << pass data only here !!
            .fill(poly.data.color)
            .gesture(
                DragGesture(minimumDistance: 0, coordinateSpace: .local)
                    .onEnded { gesture in
                        withAnimation(.easeInOut(duration:15)) {
                            poly.data.location = CGPoint(x: 200.4, y: 200.2)
                            poly.data.angle = twoPi / 3
                            poly.data.color = .red
                        }
                    }
            )
    }
}

struct ContentView_Previews: PreviewProvider {

    static var previews: some View {
        Group {
            ContentView(poly: Poly(data: PolyData(at: CGPoint(x:200,y:200), color: .blue, sides: 3, radius: 100)))
        }
    }
}
```
