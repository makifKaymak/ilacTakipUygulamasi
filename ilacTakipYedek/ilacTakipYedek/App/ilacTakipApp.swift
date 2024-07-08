//
//  ilacTakipApp.swift
//  ilacTakip
//
//  Created by Mehmet Akif Kaymak on 5.01.2024.
//

import SwiftUI
import FirebaseCore

@main
struct ilacTakipYedekApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            LoggedOrNotView()
        }
    }
}
