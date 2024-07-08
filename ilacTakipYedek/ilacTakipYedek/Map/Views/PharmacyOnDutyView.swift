import SwiftUI
import MapKit

struct PharmacyOnDutyView: View {
    let userLocation: CLLocationCoordinate2D
    @ObservedObject var locationManager: LocationManager
    
    var body: some View {
        VStack {
            List(locationManager.pharmacies, id: \.self) { pharmacy in
                Button(action: {
                    withAnimation(.easeInOut) {
                        // Eczanenin koordinatlarını kullanarak seçilen yeri ayarla
                        let coordinate = CLLocationCoordinate2D(latitude: pharmacy.latitude, longitude: pharmacy.longitude)
                        locationManager.selectedPlace = MKMapItem(placemark: MKPlacemark(coordinate: coordinate))
                        locationManager.selectedPlace?.name = pharmacy.pharmacyName
                        // Haritadaki işaretçiyi güncellemek için kullanabilirsiniz
                        // locationManager.addMarkerToMap(coordinate: coordinate, name: pharmacy.pharmacyName)
                        
                        // Sayfayı kapat
                        locationManager.showNearbyPlaces = false
                    }
                }) {
                    VStack(alignment: .leading) {
                        Text(pharmacy.pharmacyName)
                        //Text("Latitude: \(pharmacy.latitude)")
                        //Text("Longitude: \(pharmacy.longitude)")
                    }
                }
            }
        }
        .onAppear {
            locationManager.fetchDataFromURL()
        }
    }
}
