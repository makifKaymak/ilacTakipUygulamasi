//
//  CustomDatePicker.swift
//  ilacTakip
//
//  Created by Mehmet Akif Kaymak on 19.02.2024.
//

import SwiftUI

struct CustomDatePicker: View {
    
    @Binding var currentDate: Date
    @Binding var selectedDates: [Date] //Yeni
    @State var currentMonth: Int = 0
    @ObservedObject var viewModel = CalendarViewViewModel()
    
    let tomorrow = Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date()
    
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
                        .opacity(value.date < tomorrow ? 0.3 : 1)
                        .background(
                            Capsule()
                                .fill(Color("PinkAccent"))
                                .opacity(isSelectedDate(date: value.date) ? 1 : 0) //YENİ
                        )
                    
                }
            }
            
        }
        .onChange(of: currentMonth) { newValue in
            currentDate = getCurrentMonth()
        }
        
        
    }
    
    
    
    @ViewBuilder
    func CardView(value: DateValue) -> some View {
        VStack {
            if value.day != -1 {
                Text("\(value.day)")
                    .font(.title3.bold())
                    .foregroundStyle(isSelectedDate(date: value.date) ? .white : .primary)
                    .frame(maxWidth: .infinity)
                
                Spacer()
                
                if isSelectedDate(date: value.date) {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.caption)
                        .foregroundStyle(.white)
                    
                }
            }
        }
        .onTapGesture {
                if value.date <= tomorrow {
                    // Tarih bugünden sonraki bir tarih veya bugünkü ise işlemi gerçekleştirme
                    return
                }
            withAnimation {
                if let index = selectedDates.firstIndex(where: { $0 == value.date }) {
                    //viewModel.selectedDates.remove(at: index)
                    selectedDates.remove(at: index)
                    
                } else {
                    //viewModel.selectedDates.append(value.date)
                    
                    selectedDates.append(value.date)
                }
            }
        }
        .padding(.vertical, 9)
        .frame(height: 60, alignment: .top)
    }
    
    private func isSelectedDate(date: Date) -> Bool {
        selectedDates.contains(date)
    }
    
    
    /*
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
     .onTapGesture {
     withAnimation {
     currentDate = value.date
     
     }
     }
     .padding(.vertical,9)
     .frame(height: 60, alignment: .top)
     }
     */
    
    
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

extension Date {
    func getAllDates()->[Date] {
        let calendar = Calendar.current
        
        //getting start date
        let startDate = calendar.date(from: Calendar.current.dateComponents([.year, .month], from: self))!
        
        let range = calendar.range(of: .day, in: .month, for: startDate)!
        // getting data...
        return range.compactMap { day -> Date in
            
            return calendar.date(byAdding: .day, value: day - 1, to: startDate)!
            
        }
    }
}

