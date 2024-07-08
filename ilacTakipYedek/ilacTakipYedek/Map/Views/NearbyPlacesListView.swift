//
//  NearbyPlacesListView.swift
//  ilacTakipYedek
//
//  Created by Mehmet Akif Kaymak on 25.05.2024.
//

import SwiftUI
import MapKit

struct NearbyPlacesListView: View {
    let userLocation: CLLocationCoordinate2D
    @ObservedObject var locationManager: LocationManager
    
    var body: some View {
        VStack {
            //Text("User location: \(userLocation.latitude), \(userLocation.longitude)")
            
            List(locationManager.nearbyPlaces, id: \.self) { place in
                withAnimation(.easeInOut) {
                    Button(action: {
                        locationManager.selectedPlace = place
                        locationManager.showNearbyPlaces = false
                    }) {
                        Text(place.name ?? "Unknown Place")
                    }
                }
            }
        }
        .onAppear {
            locationManager.searchNearbyPlaces(coordinate: userLocation)
        }
    }
}
