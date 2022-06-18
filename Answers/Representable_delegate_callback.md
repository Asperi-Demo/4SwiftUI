```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: How to make custom MKMapView delegate actions for SwiftUI ViewRepresentable? (by )

A: Here is a solution - introduce callback property for view and inject it in your inalinable modifier. Prepared with Xcode 12.1 / iOS 14.1

```
struct MapView: UIViewRepresentable {
	func makeUIView(context: Context) -> MKMapView {
		let view = MKMapView()
		view.delegate = context.coordinator
		return view
	}
	
	func updateUIView(_ uiView: MKMapView, context: Context) {
	}

	func makeCoordinator() -> MapViewCoordinator {
		MapViewCoordinator(self)
	}
	
	var tapCallback: ((MKAnnotationView) -> ())?    // << this one !!
	
	@inlinable public func onAnnotationTapped(site: @escaping (MKAnnotationView) -> ()) -> some View {
		var newMapView = self
		newMapView.tapCallback = site            // << here !!
		return newMapView
	}
	
	public class MapViewCoordinator: NSObject, MKMapViewDelegate {
		var mapView: MapView
		
		init(_ control: MapView) {
			self.mapView = control
		}
		
		public func mapView(_ mkMap: MKMapView, didSelect view: MKAnnotationView) {
			self.mapView.tapCallback?(view)     // << call !!
		}
	}
}
```
