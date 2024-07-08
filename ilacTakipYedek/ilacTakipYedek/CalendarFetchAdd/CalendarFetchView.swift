//
//  CalendarFetchView.swift
//  ilacTakip
//
//  Created by Mehmet Akif Kaymak on 16.03.2024.
//

import SwiftUI
import FirebaseAuth

struct CalendarFetchView: View {
    
    @StateObject var viewModel = CalendarViewViewModel()
    
    var body: some View {
        VStack {
            
            CustomDateFetchPicker(currentDate: $viewModel.selectedDate)
            
            // Eklenen İlaçlar Listesi
            
            VStack(spacing: 15) {
                Text("Medicines")
                    .font(.title2.bold())
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.vertical, 20)
                
                //Bu kısıma firebaseden çektiğimiz ilaç bilgileri gelecek.
                ScrollView {
                    LazyVStack {    
                        ForEach(viewModel.medicines) { medicine in
                            NavigationLink(destination: MedicineDetailView(medicine: medicine)) {
                                MedicineListView(medicine: medicine)
                                    .contextMenu {
                                        Button(action: {
                                            viewModel.deleteMed(medicine: medicine)
                                        }) {
                                            Text("Delete")
                                                .foregroundStyle(.red)
                                            Image(systemName: "trash")
                                        }
                                        .disabled(viewModel.isDeleting)
                                        Button(action: {
                                            viewModel.medicine = medicine
                                            viewModel.isEditing.toggle()
                                        }) {
                                            Text("Edit")
                                                .foregroundStyle(.red)
                                            Image(systemName: "pencil")
                                        }
                                        
                                    }
                                    .buttonStyle(PlainButtonStyle())
                            }
                            
                            
                        }
                    }
                    
                }
                
                
            }
            .sheet(isPresented: $viewModel.isEditing) {
                if let medicine = viewModel.medicine {
                    EditingView(medicine: medicine)
                }
                
            }
            .sheet(isPresented: $viewModel.isDeleting, content: {
                if #available(iOS 16.4, *) {
                    DeletingView()
                        .presentationDetents([.height(350)])
                        .presentationCornerRadius(30)
                } else {
                    DeletingView()
                        .presentationDetents([.height(350)])
                    
                }
            })
            .onAppear {
                viewModel.fetch()
                //viewModel.checkAndDeleteOldMedicines()
            }
            .onChange(of: viewModel.selectedDate) { _ in
                viewModel.fetch()
            }
            .onChange(of: viewModel.isEditing) { _ in
                viewModel.fetch()
            }
            .onChange(of: viewModel.isDeleting) { _ in
                viewModel.fetch()
            }
            
            
            
        }
        
    }
    
    
}



#Preview {
    CalendarFetchView()
}
