//
//  MedicineDetailView.swift
//  ilacTakip
//
//  Created by Mehmet Akif Kaymak on 31.03.2024.
//

import SwiftUI


struct MedicineDetailView: View {
    var medicine: Medicine

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Medicine name: \(medicine.medicineName)")
                .font(.title)
            Text("Medicine type: \(medicine.medicineType)")
                .font(.headline)
            Text("Frequency of taking medicine: \(medicine.frequencyOfTakingTheDrug)")
                .font(.headline)
            Text("Time: \(medicine.time)")
                .font(.headline)
            Text("Properties: \(medicine.properties)")
                .font(.headline)
            
        }
        .padding()
        .navigationTitle("Medicine Details")
    }
}
 




