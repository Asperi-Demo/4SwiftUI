Q: SwiftUI: Place and drag object immediately (by Pete)

A: A possible approach is to handle drag and creation in "area" (background container), while "item" views are just rendered at the place where needed.

Find below a simplified demo (used Xcode 13.2 / iOS 15.2), see also comments in code snapshot.

![y4z9z-2](https://user-images.githubusercontent.com/62171579/184883239-ff84e3ee-bcd2-4019-b266-70ee77948ed6.gif)

*Note: tap detection in already "existed" item is an exercise for you.*  

```
extension CGPoint: Identifiable { // just a helper for demo
	public var id: String { "\(x)-\(y)" }
}

struct TapAndDragDemo: View {
    @State private var points: [CGPoint] = [] // << persistent
    @State private var point: CGPoint?    // << current

    @GestureState private var dragState: CGSize = CGSize.zero

    var body: some View {
        Color.clear.overlay(        // << area
        	Group {
         		ForEach(points) {   // << stored `items`
					Rectangle()
                        .frame(width: 24, height: 24)
     					.position(x: $0.x, y: $0.y)
                }
                if let curr = point {  // << active `item`
					Rectangle().fill(Color.red)
                        .frame(width: 24, height: 24)
     					.position(x: curr.x, y: curr.y)
                }
            }
        )
        .contentShape(Rectangle()) // << make area tappable
        .gesture(DragGesture(minimumDistance: 0.0)
            .updating($dragState) { drag, state, _ in
            	state = drag.translation
            }
            .onChanged {
                point = $0.location   // track drag current
	        }
            .onEnded {
                points.append($0.location) // push to stored
                point = nil
        	}
        )
    }
}
```
