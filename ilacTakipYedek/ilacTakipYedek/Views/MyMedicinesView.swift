//
//  MyMedicinesView.swift
//  ilacTakipYedek
//
//  Created by Mehmet Akif Kaymak on 5.05.2024.
//

import SwiftUI

struct MyMedicinesView: View {
    @StateObject var viewModel = CalendarViewViewModel()
    var body: some View {
        ScrollView {
            LazyVStack {
                if viewModel.medicines.isEmpty {
                    ZStack {
                        Capsule()
                            .foregroundColor(Color("PinkAccent").opacity(0.75))
                        Text("İlaçlarınız yok")
                            .foregroundColor(.renk)
                            .padding()
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                } else {
                    ForEach(viewModel.medicines) { medicine in
                        MedicineCard(medicine: medicine)
                            .padding()
                        
                    }
                }
            }
        }
        .onAppear {
            viewModel.fetchAllMedicines()
        }
    }
}

struct MedicineCard: View {
    var medicine: Medicine
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Spacer()
            Text("Medicine Name: \(medicine.medicineName)")
            Text("Medicine Type: \(medicine.medicineType)")
            Text("Doases: \(medicine.frequencyOfTakingTheDrug)")
            Text("Reminder Type: \(medicine.remindType)")
            Text("Time: \(medicine.time)")
            
        }
        .foregroundStyle(.renk)
        .padding(.vertical)
        .padding(.horizontal, 60)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            Color("PinkAccent")
                .opacity(0.75)
                .clipShape(Capsule())
        )
        .overlay(
            Text("Date: \(medicine.date)")
                .foregroundStyle(.renk)
                .font(.caption)
                .padding(.horizontal, 60)
                .padding(.vertical, 15), alignment: .topLeading
        )
        
    }
}

#Preview {
    MyMedicinesView()
}
