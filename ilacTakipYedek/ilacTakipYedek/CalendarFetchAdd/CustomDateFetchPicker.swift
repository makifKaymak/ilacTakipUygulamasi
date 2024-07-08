//
//  CustomDateFetchPicker.swift
//  ilacTakipYedek
//
//  Created by Mehmet Akif Kaymak on 23.04.2024.
//

import SwiftUI

import SwiftUI

struct CustomDateFetchPicker: View {
    
    @Binding var currentDate: Date
    @State var currentMonth: Int = 0
    @StateObject var viewModel = CalendarViewViewModel()
    
    var body: some View {
        
        VStack(spacing: 35) {
            
            let days: [String] = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
            
            HStack(spacing: 20) {
                VStack(alignment: .leading, spacing: 10) {
                    
                    Text(extraDate()[0])
                        .font(.caption)
                        .fontWeight(.semibold)
                    
                    Text(extraDate()[1])
                        .font(.title.bold())
                }
                
                Spacer(minLength: 0)
                
                Button {
                    withAnimation {
                        currentMonth -= 1
                    }
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                        .foregroundStyle(.pinkAccent)
                }
                
                Button {
                    withAnimation {
                        currentMonth += 1
                    }
                } label: {
                    Image(systemName: "chevron.right")
                        .font(.title2)
                        .foregroundStyle(.pinkAccent)
                }
                
                
            }
            .padding(.horizontal)
            // Day View
            
            HStack(spacing: 0) {
                ForEach(days, id: \.self) { day in
                    Text(day)
                        .font(.callout)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                }
            }
            
            // Dates...
            // Lazy Grid
            let columns = Array(repeating: GridItem(.flexible()), count: 7)
            
            LazyVGrid(columns: columns, spacing: 15) {
                ForEach(extractDate()) { value in
                    CardView(value: value)
                        .background(
                            Capsule()
                                .fill(Color("PinkAccent"))
                                .opacity(isSameDay(date1: value.date, date2: currentDate) ? 1 : 0)
                                
                        )
                        .onTapGesture {
                            withAnimation {
                                currentDate = value.date
                            }
                            
                        }
                        
                }
            }
            
        }
        .onChange(of: currentMonth) { newValue in
            currentDate = getCurrentMonth()
        }
        
        
    }
    
    
    @ViewBuilder
    func CardView(value: DateValue)->some View {
        VStack {
            if value.day != -1 {
                if let medicine = viewModel.medicine, isSameDay(date1: medicine.date.toDate() ?? Date(), date2: value.date) {
                    Text("\(value.day)")
                        .font(.title3.bold())
                        .foregroundStyle(isSameDay(date1: medicine.date.toDate() ?? Date(), date2: currentDate) ? .white : .primary)
                        .frame(maxWidth: .infinity)
                    
                    Spacer()
                    
                    Circle()
                        .fill(Color("PinkAccent"))
                        .frame(width: 8, height: 8)
                } else {
                    Text("\(value.day)")
                        .font(.title3.bold())
                        .foregroundStyle(isSameDay(date1: value.date, date2: currentDate) ? .white : .primary)
                        .frame(maxWidth: .infinity)
                    Spacer()
                }
                     
            }
        }
        .padding(.vertical,9)
        .frame(height: 60, alignment: .top)
    }
    
    
    //checking dates...
    func isSameDay(date1: Date, date2: Date)->Bool {
        let calendar = Calendar.current
        
        return calendar.isDate(date1, inSameDayAs: date2)
    }
    
    func extraDate()->[String] {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY MMMM"
        
        let date = formatter.string(from: currentDate)
        
        return date.components(separatedBy: " ")
    }
    
    func getCurrentMonth()->Date {
        let calendar = Calendar.current
        
        // Getting Current Month Data....
        guard let currentMonth = calendar.date(byAdding: .month, value: self.currentMonth, to: Date()) else {
            return Date()
        }
        
        return currentMonth
    }
    
    func extractDate() ->[DateValue] {
        
        let calendar = Calendar.current
        let currentMonth = getCurrentMonth()
        
        var days = currentMonth.getAllDates().compactMap { date -> DateValue in
            
            let day = calendar.component(.day, from: date)
            
            return DateValue(day: day, date: date)
        }
        
        let firstWeekday = calendar.component(.weekday, from: days.first?.date ?? Date())
        
        for _ in 0..<firstWeekday - 1 {
            days.insert(DateValue(day: -1, date: Date()), at: 0)
        }
        
        return days
    }
    
}


#Preview {
    CustomDateFetchPicker(currentDate: .constant(Date()))
}
