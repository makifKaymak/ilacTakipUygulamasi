//
//  AddView.swift
//  ilacTakip
//
//  Created by Mehmet Akif Kaymak on 19.02.2024.
//

import SwiftUI

struct AddView: View {
    @State var currentDate: Date = Date()
    
    
    var body: some View {
        NavigationStack{
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 20) {
                    CalendarAddView()
                }
            }
            
        }
    }
}

