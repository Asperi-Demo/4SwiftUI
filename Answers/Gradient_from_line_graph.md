```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: Make Line chart gradient color go from line to bottom - SwiftUI (by Nicolaj Spiegelhauer)

A: Here is possible solution - use same graph for clipped background (we need closed path for that) and another variant for stroked line.

Prepared with Xcode 12.4 / iOS 14.4

![rht9X](https://user-images.githubusercontent.com/62171579/167889867-6a32fb12-7350-4765-8760-31dd023be1e9.png)

```
struct Graph: View {
  let dataPoints: [CGFloat] = [1, 0.8, 0.7, 0.5, 0.7, 0.4, 0.5, 0.6, 0.8, 0.4, 0.3, 0.4, 0.5, 0.7, 0.6, 1]

  var body: some View {
    ZStack{
      LinearGradient(gradient:
        Gradient(colors: [Color(#colorLiteral(red: 0.4901960784, green: 0.5058823529, blue: 0.9803921569, alpha: 1)), Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))]), startPoint: .top, endPoint: .bottom)
        .clipShape(LineGraph(dataPoints: dataPoints, closed: true))  // << !!

      LineGraph(dataPoints: dataPoints)
        .stroke(Color(#colorLiteral(red: 0.2784313725, green: 0.2901960784, blue: 0.9568627451, alpha: 1)), lineWidth: 2)
    }
    .frame(width: 124, height: 90, alignment: .center)
  }
  
}


struct LineGraph: Shape {
  var dataPoints: [CGFloat]
  var closed = false        // << indicator for variants !!
  
  func path(in rect: CGRect) -> Path {
    
    func point(at ix: Int) -> CGPoint {
      let point = dataPoints[ix]
      let x = rect.width * CGFloat(ix) / CGFloat(dataPoints.count - 1)
      let y = (1 - point) * rect.height
      
      return CGPoint(x: x, y: y)
    }
    
    return Path { p in
      
      guard dataPoints.count > 1 else {return}
      
      let start = dataPoints[0]
      p.move(to: CGPoint(x: 0, y: (1 - start) * rect.height))
      
      for index in dataPoints.indices {
        p.addLine(to: point(at: index))
      }

      if closed {   // << variant for clipping !!
        p.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        p.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        p.closeSubpath()
      }
    }
  }
}
```
