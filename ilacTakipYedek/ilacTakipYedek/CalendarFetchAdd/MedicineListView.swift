//
//  MedicineListView.swift
//  ilacTakipYedek
//
//  Created by Mehmet Akif Kaymak on 27.04.2024.
//

import SwiftUI

struct MedicineListView: View {
    
    var medicine: Medicine
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 8) {
            Text("Medicine: \(medicine.medicineName)")
            Text("Type: \(medicine.medicineType)")
            Text("Doses: \(medicine.frequencyOfTakingTheDrug)")
        }
        .foregroundStyle(.renk)
        .padding(.vertical, 15)
        .padding(.horizontal, 30)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            Color("PinkAccent")
                .opacity(0.75)
                .clipShape(Capsule())
        )
        .overlay(
            Text("Time: \(medicine.time)")
                .foregroundStyle(.renk)
                .font(.caption)
                .padding(.horizontal, 30)
                .padding(.vertical, 15), alignment: .topTrailing
        )
        
    }
    
}

