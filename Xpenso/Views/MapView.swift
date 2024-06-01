//import SwiftUI
//import MapKit
//
//struct MapView: View {
//    @StateObject private var locationManager = LocationManager()
//    @State private var textToSearch = ""
//    @State private var searchResults: [MKMapItem] = []
//
//    @State private var region = MKCoordinateRegion(
//        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
//        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
//    )
//
//    var body: some View {
//        ZStack {
//            Map(coordinateRegion: $region)
//                .ignoresSafeArea(.all)
//
//            VStack {
//                HStack {
//                    TextField("Search Something", text: $textToSearch, onCommit: {
//                        searchForPlaces()
//                    })
//                    .padding(.all, 8)
//                    .background(Color.black.opacity(0.05))
//                    .cornerRadius(8)
//                    .padding(.leading, 16)
//
//                    Button(action: {
//                        searchForPlaces()
//                    }) {
//                        Text("Search")
//                            .padding(.horizontal, 16)
//                            .padding(.vertical, 8)
//                            .background(Color.blue)
//                            .foregroundColor(.white)
//                            .cornerRadius(8)
//                    }
//                    .padding(.trailing)
//                }
//                
//                if !searchResults.isEmpty {
//                    List(searchResults, id: \.self) { mapItem in
//                        VStack(alignment: .leading) {
//                            Text(mapItem.name ?? "")
//                                .font(.headline)
//                            Text(mapItem.placemark.title ?? "")
//                                .font(.subheadline)
//                        }
//                        .onTapGesture {
//                            if let coordinate = mapItem.placemark.location?.coordinate {
//                                region = MKCoordinateRegion(
//                                    center: coordinate,
//                                    span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
//                                )
//                            }
//                            searchResults.removeAll()
//                        }
//                    }
//                    .cornerRadius(8)
//                    .background(Color.black.opacity(0.9))
//
//                }
//
//
//                Spacer()
//            }
//            
//        }
//    }
//
//    func searchForPlaces() {
//        let request = MKLocalSearch.Request()
//        request.naturalLanguageQuery = textToSearch
//        let search = MKLocalSearch(request: request)
//        search.start { response, error in
//            guard let response = response else {
//                print("Error: \(error?.localizedDescription ?? "Unknown error")")
//                return
//            }
//            searchResults = response.mapItems
//        }
//    }
//}
//
//struct MapView_Previews: PreviewProvider {
//    static var previews: some View {
//        MapView()
//    }
//}
//
//class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
//    private let locationManager = CLLocationManager()
//
//    @Published var region = MKCoordinateRegion(
//        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
//        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
//    )
//
//    override init() {
//        super.init()
//        locationManager.delegate = self
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        locationManager.requestWhenInUseAuthorization()
//        locationManager.startUpdatingLocation()
//    }
//
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        guard let location = locations.last else { return }
//        region = MKCoordinateRegion(
//            center: location.coordinate,
//            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
//        )
//    }
//}
