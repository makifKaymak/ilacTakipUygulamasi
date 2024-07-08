//
//  LoggedOrNotView.swift
//  ilacTakip
//
//  Created by Mehmet Akif Kaymak on 14.02.2024.
//

import SwiftUI
import FirebaseAuth

struct LoggedOrNotView: View {
    
    @StateObject var viewModel = LoggedOrNotViewViewModel()
    
    var body: some View {
        
        if viewModel.isSignedIn, !viewModel.currentUserId.isEmpty {
            HomeView()
        } else {
            LoginSignUpContentView()//userId: viewModel.currentUserId)
        }
        
        
    }
}

#Preview {
    LoggedOrNotView()
}
