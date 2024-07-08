import SwiftUI

struct CalendarAddView: View {
    @ObservedObject var viewModel = CalendarViewViewModel()
    
    var body: some View {
        NavigationStack {
            VStack { 
                // Calendar View
                CustomDatePicker(currentDate: $viewModel.selectedDate, selectedDates: $viewModel.selectedDates)
                
                //CustomDatePicker(currentDate: $viewModel.selectedDate)
                
                GradientButton(title: "Continue", icon: "arrow.right", onClick: {
                    viewModel.OtherView = true
                    
                })
                .disabled($viewModel.selectedDates.isEmpty)
                .opacity($viewModel.selectedDates.isEmpty ? 0.5 : 1)
                
            }
            
            
        }
        .navigationDestination(isPresented: $viewModel.OtherView) {
            CalendarMedicineAddView(selectedDate: $viewModel.selectedDate, viewModel: viewModel, selectedDates: $viewModel.selectedDates)
                .navigationBarBackButtonHidden(true)
                .toolbar {
                    
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            viewModel.OtherView = false
                            viewModel.selectedDates.removeAll()
                        }) {
                            Image(systemName: "chevron.left")
                                .tint(.pinkAccent)
                            
                        }
                    }
                    
                }
        }
        
    }
    
}


extension String {
    func toDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        return dateFormatter.date(from: self)
    }
}



#Preview {
    CalendarAddView()
}


