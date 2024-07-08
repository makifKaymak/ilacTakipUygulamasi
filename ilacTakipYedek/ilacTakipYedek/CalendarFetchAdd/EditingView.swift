//
//  EditingView.swift
//  ilacTakipYedek
//
//  Created by Mehmet Akif Kaymak on 27.04.2024.
//

import SwiftUI

struct EditingView: View {
    
    var medicine: Medicine
    @StateObject var viewModel = CalendarViewViewModel()
    @State var editingName = ""
    @State var editingmedicineType = ""
    @State var editingFrequenceMedicine = ""
    
    let medicineTypes = ["IU", "Ampoule", "Unit", "Drop", "injection", "Suppository", "Gram", "Pill", "Capsule", "Miligram", "Milliliter", "mm", "Exhalation", "Package", "Piece", "Portion", "Spray", "Tea spoon", "Soup spoon"]
    
    var body: some View {
        VStack {
            
            VStack {
                TextField("Medicine Name", text: $editingName)
                    .modifier(TextFieldModifier1())
                TextField("Doases", text: $editingFrequenceMedicine)
                    .modifier(TextFieldModifier1())
                Picker("Medicine Type", selection: $editingmedicineType) {
                    Text("Select a type").tag(nil as String?)
                    ForEach(medicineTypes, id: \.self) { type in
                        Text(type).tag(type as String?)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .fontWeight(.bold)
                .tint(.renk)
                .background(Color.pinkAccent, in: .capsule)
            }
            .padding(.vertical, 50)
            
            Spacer()
            
            VStack {
                GradientButton(title: "Update", icon: "rectangle.and.pencil.and.ellipsis") {
                    if (!editingName.isEmpty) {
                        viewModel.update(medicine: medicine, updatedData: ["medicineName": "\(editingName)"])
                    }
                    if (!editingFrequenceMedicine.isEmpty) {
                        viewModel.update(medicine: medicine, updatedData: ["frequencyOfTakingTheDrug": "\(editingFrequenceMedicine)"])
                    }
                    
                    if(!editingmedicineType.isEmpty) {
                        viewModel.update(medicine: medicine, updatedData: ["medicineType": "\(editingmedicineType)"])
                    }
                }
            }
            .padding(.vertical, 50)
            
            
            
        }
        
        .onAppear {
            viewModel.fetch()
        }
        .onChange(of: viewModel.isEditing) { _ in
            viewModel.fetch()
        }
         
    }
        
}
