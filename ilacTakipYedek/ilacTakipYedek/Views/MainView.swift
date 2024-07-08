//
//  MainView.swift
//  ilacTakip
//
//  Created by Mehmet Akif Kaymak on 20.02.2024.
//

import SwiftUI

struct MainView: View {
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 20) {
                    CalendarFetchView()
                }
            }
        }
    }
}

#Preview {
    MainView()
}
