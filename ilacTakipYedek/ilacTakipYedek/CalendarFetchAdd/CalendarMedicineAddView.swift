//
//  CalendarMedicineAddView.swift
//  ilacTakip
//
//  Created by Mehmet Akif Kaymak on 30.03.2024.
//

import SwiftUI

struct CalendarMedicineAddView: View {
    
    @State private var errorMessage = ""
    @State private var showError = false
    @State private var showSuccessMessage = false
    @Binding var selectedDate: Date
    @ObservedObject var viewModel = CalendarViewViewModel()
    @Binding var selectedDates : [Date]
    
    let notify = NotificationHandler()
    
    let medicineTypes = ["IU", "Ampoule", "Unit", "Drop", "injection", "Suppository", "Gram", "Pill", "Capsule", "Miligram", "Milliliter", "mm", "Exhalation", "Package", "Piece", "Portion", "Spray", "Tea spoon", "Soup spoon"]
    let remindType = ["Once a day","Twice a day", "3 Times a day", "4 Times a day"]
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                Image("pillWallpaper")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .opacity(0.35)
                    
                ScrollView {
                    VStack {
                        VStack {
                            
                            TextField("Medicine Name", text: $viewModel.medicineName)
                                .modifier(TextFieldModifier1())
                            
                            TextField("Doases", text: $viewModel.frequencyOfTakingTheDrug)
                                .modifier(TextFieldModifier1())
                            
                            TextEditor(text: $viewModel.properties)
                                .frame(height: 320)
                                .modifier(TextFieldModifier2())
                            
                        }
                        //.padding(.vertical,10)
                        
                        HStack {
                                
                            Picker("Medicine Type", selection: $viewModel.medicineType) {
                                Text("Select a type").tag(nil as String?)
                                ForEach(medicineTypes, id: \.self) { type in
                                    Text(type).tag(type as String?)
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                            .fontWeight(.bold)
                            .tint(.renk)
                            //.foregroundStyle(.renk)
                            .background(Color.pinkAccent, in: .capsule)
                            //.background(.gray.opacity(0.4), in: .capsule)
                            
                            Picker("Remind When", selection: $viewModel.remindType) {
                                Text("Remind When").tag(nil as String?)
                                ForEach(remindType, id: \.self) { type in
                                    Text(type).tag(type as String?)
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                            .fontWeight(.bold)
                            .tint(.renk)
                            //.foregroundStyle(.renk)
                            .background(Color.pinkAccent, in: .capsule)
                            //.background(.gray.opacity(0.4), in: .capsule)
                            
                            DatePicker("Text", selection: $viewModel.selectedTime, displayedComponents: .hourAndMinute)
                                .labelsHidden()
                                .tint(.renk)
                                .background(Color("PinkAccent"))
                                .clipShape(Capsule())
                                
                        }
                        //.padding(.vertical, 10)
                        
                        GradientButton(title: "Add medicine", icon: "plus.circle") {
                            viewModel.add()
                            showSuccessMessage = true
                            
                        }
                        .disabled(viewModel.medicineName.isEmpty || viewModel.frequencyOfTakingTheDrug.isEmpty || viewModel.medicineType.isEmpty)
                        .opacity(viewModel.medicineName.isEmpty || viewModel.frequencyOfTakingTheDrug.isEmpty || viewModel.medicineType.isEmpty  ? 0.5 : 1)
                        //.padding(.vertical, 20)
                        
         
                    }
                    .onDisappear {
                        // Görünüm kaybolduğunda viewModel'daki alanları sıfırlıyoruz
                        viewModel.medicineName = ""
                        viewModel.frequencyOfTakingTheDrug = ""
                        viewModel.medicineType = ""
                        viewModel.properties = ""
                    }
                    .alert(isPresented: $showSuccessMessage) {
                        Alert(title: Text("Success"), message: Text("Your medicine has been added successfully."), dismissButton: .default(Text("OK")){
                            //Burda da alanları tekrardan sıfırlıyoruz showSuccessMessage = true olursa
                            viewModel.hideKeyboard()
                            withAnimation{
                                viewModel.medicineName = ""
                                viewModel.frequencyOfTakingTheDrug = ""
                                viewModel.medicineType = ""
                                viewModel.properties = ""
                            }
                        })
                        
                    }
                    .navigationTitle("Medicine Details")
                .navigationBarTitleDisplayMode(.inline)
                }
            }
            
        }
        
    }
}

#Preview {
    CalendarMedicineAddView(selectedDate : .constant(Date()), viewModel: CalendarViewViewModel(), selectedDates: .constant([Date]()))
}


