import Foundation
import MapKit

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private var locationManager = CLLocationManager()
    
    @Published var userLocation: CLLocationCoordinate2D?
    @Published var nearbyPlaces: [MKMapItem] = []
    @Published var selectedPlace: MKMapItem?
    @Published var showNearbyPlaces = false
    @Published var pharmacies: [Pharmacy] = []
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        userLocation = location.coordinate
        fetchDataFromURL()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to get user location: \(error.localizedDescription)")
    }
    
    func searchNearbyPlaces(coordinate: CLLocationCoordinate2D) {
        // Function to perform a search with a given query
        func performSearch(query: String, completion: @escaping ([MKMapItem]) -> Void) {
            let request = MKLocalSearch.Request()
            request.naturalLanguageQuery = query
            request.region = MKCoordinateRegion(
                center: coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            )
            
            let search = MKLocalSearch(request: request)
            search.start { response, error in
                guard let response = response else {
                    print("Error: \(error?.localizedDescription ?? "Unknown error")")
                    completion([])
                    return
                }
                completion(response.mapItems)
            }
        }
        
        var allResults: [MKMapItem] = []
        
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        performSearch(query: "eczane") { results in
            allResults.append(contentsOf: results)
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            self.nearbyPlaces = allResults.sorted { place1, place2 in
                guard let userLocation = self.userLocation else { return false }
                let distance1 = CLLocation(latitude: place1.placemark.coordinate.latitude, longitude: place1.placemark.coordinate.longitude).distance(from: CLLocation(latitude: userLocation.latitude, longitude: userLocation.longitude))
                let distance2 = CLLocation(latitude: place2.placemark.coordinate.latitude, longitude: place2.placemark.coordinate.longitude).distance(from: CLLocation(latitude: userLocation.latitude, longitude: userLocation.longitude))
                return distance1 < distance2
            }
        }
    }
    
    func fetchDataFromURL() {
        guard let userLocation = userLocation else {
            print("Error: User location not available.")
            return
        }
        
        let latitude = userLocation.latitude
        let longitude = userLocation.longitude
        
        let urlString = "https://www.nosyapi.com/apiv2/service/pharmacies-on-duty/locations?latitude=\(latitude)&longitude=\(longitude)&apiKey=JpMVY867vWfrQPQbhpW0Yav4fCWZk82naAf0l6UUKUq63w9R1EjwYxB8kX4B"
        
        guard let url = URL(string: urlString) else {
            print("Error: Invalid URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                print("Error: No data received")
                return
            }
            
            if let rawJson = String(data: data, encoding: .utf8) {
                print("Raw JSON data: \(rawJson)")
            }
            
            do {
                let response = try JSONDecoder().decode(PharmacyResponse.self, from: data)
                let pharmacies = response.data
                
                print("Decoded pharmacies: \(pharmacies)")
                
                DispatchQueue.main.async {
                    self.pharmacies = pharmacies
                }
                
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }
        
        task.resume()
    }
    
    func getDirections(from userLocation: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D, completion: @escaping (MKRoute?) -> Void) {
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: userLocation))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: destination))
        request.transportType = .automobile
        
        let directions = MKDirections(request: request)
        directions.calculate { response, error in
            if let error = error {
                print("Error getting directions: \(error.localizedDescription)")
                completion(nil)
            } else if let route = response?.routes.first {
                completion(route)
            } else {
                completion(nil)
            }
        }
    }
    
    /*
     func addMarkerToMap(coordinate: CLLocationCoordinate2D, name: String) {
     let placemark = MKPlacemark(coordinate: coordinate)
     let mapItem = MKMapItem(placemark: placemark)
     mapItem.name = name
     selectedPlace = mapItem
     }
     
     */
    
}
