//
//  HomeView.swift
//  ilacTakip
//
//  Created by Mehmet Akif Kaymak on 5.01.2024.
//

import SwiftUI

struct HomeView: View {
    
    var body: some View {
        ZStack {
            VStack {
                TabView {
                    MainView()
                        .tabItem {
                            Label("Home Screen", systemImage: "house.fill")
                        }
                    AddView()
                        .tabItem {
                            Label("Add", systemImage: "pills.fill")
                        }
                    MyMedicinesView()
                        .tabItem {
                            Label("My Medicines", systemImage: "pills.circle.fill")
                        }
                    PharmacyView()
                        .tabItem {
                            Label("Pharmacies", systemImage: "map.fill")
                        }
                    OthersView()
                        .tabItem {
                            Label("Other", systemImage: "ellipsis")
                        }
                }
                .tint(.pinkAccent)
            }
            
        }
        
    }
}


#Preview {
    HomeView()
}
