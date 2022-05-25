```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: adding a MapMarker to MapKit in swiftUI 2 (by mtz_federico)

A: Here is a simple demo - annotation items should be identifiable, so create a model and compose corresponding map markers. 

Tested with Xcode 12 / iOS 14

![3UCIV](https://user-images.githubusercontent.com/62171579/170195519-32622d43-41ad-4ba9-ad27-d5c1ebaf17e3.png)

```
import CoreLocation
import MapKit

struct Marker: Identifiable {   // << here !!
    let id = UUID()
    var location: MapMarker
}

struct DemoView: View {

    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 38.8977, longitude: -77.0365), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))

    let markers = [Marker(location: MapMarker(coordinate: CLLocationCoordinate2D(latitude: 38.8977, longitude: -77.0365), tint: .red))]


    var body: some View {
        Map(coordinateRegion: $region, showsUserLocation: true, 
          annotationItems: markers) { marker in
            marker.location                       // << here !1
        }.edgesIgnoringSafeArea(.all)
    }
}
```
