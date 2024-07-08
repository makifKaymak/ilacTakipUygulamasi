//
//  harita.swift
//  ilacTakip
//
//  Created by Mehmet Akif Kaymak on 7.01.2024.
//

import SwiftUI
import MapKit


struct MapView: View {
    
    @StateObject private var locationManager = LocationManager()
    @State private var position: MapCameraPosition = .userLocation(fallback: .automatic)
    //@State private var selectedPharmacy: Pharmacy?
    //@State private var pharmacyData: Pharmacy
    
    @State private var route: MKRoute?
    
    
    var body: some View {
        NavigationStack {
            VStack {
                Map(position: $position) {
                    UserAnnotation()
                    
                    if let place = locationManager.selectedPlace {
                        
                        if let placeName = place.name {
                            Marker(placeName, coordinate: place.placemark.coordinate)
                        } else {
                            Marker("Unknown Place", coordinate: place.placemark.coordinate)
                        }
                        if let route = route {
                            MapPolyline(route.polyline)
                                .stroke(Color.pinkAccent, lineWidth: 5)
                        }
                    }
                    
                }
                
                .mapControls {
                    MapUserLocationButton()
                    MapPitchToggle()
                }
                .onAppear {
                    CLLocationManager().requestWhenInUseAuthorization()
                }
                .onChange(of: locationManager.selectedPlace) { newPlace in
                    if let newPlace = newPlace {
                        self.route = nil
                        zoomToLocation(coordinate: newPlace.placemark.coordinate)
                    }
                }
                if let userLocation = locationManager.userLocation, let selectedPlace = locationManager.selectedPlace {
                    Button("Yol Tarifi Al") {
                        locationManager.getDirections(from: userLocation, to: selectedPlace.placemark.coordinate) { route in
                            if let route = route {
                                self.route = route
                                zoomToLocation(coordinate: userLocation)
                            }
                        }
                    }
                    .padding()
                }
                
            }
            .navigationBarTitle("Pharmacies", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        locationManager.showNearbyPlaces.toggle()
                    }) {
                        Image(systemName: locationManager.showNearbyPlaces ? "list.bullet.circle.fill" : "list.bullet.circle")
                    }
                }
            }
            .sheet(isPresented: $locationManager.showNearbyPlaces) {
                VStack {
                    VStack {
                        Text("Yakındaki Nöbetçi Eczaneler")
                            .font(.headline)
                            .padding(.top)
                        if let userLocation = locationManager.userLocation {
                            PharmacyOnDutyView(userLocation: userLocation, locationManager: locationManager)
                            
                        } else {
                            Text("Fetching user location...")
                                .padding()
                        }
                    }
                    
                    VStack {
                        Text("Yakındaki Eczaneler")
                            .font(.headline)
                            .padding(.top)
                        if let userLocation = locationManager.userLocation {
                            NearbyPlacesListView(userLocation: userLocation, locationManager: locationManager)
                        } else {
                            Text("Fetching user location...")
                                .padding()
                        }
                    }
                }
            }
            
        }
    }
    
    private func zoomToLocation(coordinate: CLLocationCoordinate2D) {
        withAnimation(.easeInOut) {
            position = .region(MKCoordinateRegion(
                center: coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            ))
        }
    }
}


