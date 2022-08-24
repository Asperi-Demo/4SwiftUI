// 🔥BOYCOTT on russia - terrorist must be punished!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI
import MapKit

struct TestPersonAnnotationOnMap: View {
	
	class Person: NSObject, MKAnnotation {
		var coordinate: CLLocationCoordinate2D
		let title: String?
		
		init(coordinate: CLLocationCoordinate2D, title: String?) {
			self.coordinate = coordinate
			self.title = title
		}
	}
	
	@State private var persons: [Person] = [
		.init(
			coordinate: .init(latitude: 50.7123012, longitude: 5.1231021),
			title: "Person 1"
		),
		.init(
			coordinate: .init(latitude: 49.3123012, longitude: 5.1231021),
			title: "Person 2"
		)
	]
	
	var body: some View {
		VStack {
			MapView(persons: $persons)
			Button("Remove Person at index 0") {
				persons.remove(at: 0)
			}
		}
	}
	
	struct MapView: UIViewRepresentable {
		@Binding var persons: [Person]
		
		init(persons: Binding<[Person]>) {
			self._persons = persons
		}
		
		func makeUIView(context: Context) -> MKMapView {
			let mapView = MKMapView()
			mapView.delegate = context.coordinator
			mapView.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: "testAnnotation")
			return mapView
		}
		
		func updateUIView(_ mapView: MKMapView, context: Context) {
			mapView.removeAnnotations(mapView.annotations)
			mapView.addAnnotations(persons)
		}
		
		func makeCoordinator() -> Coordinator {
			Coordinator(self)
		}
		
		class Coordinator: NSObject, MKMapViewDelegate {
			
			var parent: MapView
			
			init(_ parent: MapView) {
				self.parent = parent
			}
			
			func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
				if let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "testAnnotation", for: annotation) as? MKMarkerAnnotationView {
					annotationView.glyphImage = UIImage(systemName: "person")
					return annotationView
				}
				
				return nil
			}
		}
	}
}

struct TestPersonAnnotationOnMap_Previews: PreviewProvider {
	static var previews: some View {
		TestPersonAnnotationOnMap()
	}
}
