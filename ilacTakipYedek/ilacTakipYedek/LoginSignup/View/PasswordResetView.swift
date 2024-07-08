//
//  PasswordResetView.swift
//  ilacTakip
//
//  Created by Mehmet Akif Kaymak on 13.02.2024.
//

import SwiftUI

struct PasswordResetView: View {
    
    @StateObject private var viewModel = PasswordResetViewModel()
    // Environment Properties
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(alignment: .leading,spacing: 15, content: {
            // Back Button
            Button(action: {
                dismiss()
            }, label: {
                Image(systemName: "xmark")
                    .font(.title2)
                    .foregroundStyle(.gray)
            })
            .padding(.top, 10)
            
            Text("Reset Password?")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .padding(.top, 5)
            
            VStack(spacing: 25) {
                // Custom Text Fields
                TextField("Enter e-mail", text: $viewModel.email)
                    .modifier(TextFieldModifier())
                    .textInputAutocapitalization(.never)
                // Reset Button
                GradientButton(title: "Send Link", icon: "arrow.right") {
                    // Buraya code yaz firebaseden işte bi şekilde bişiler link yollansın falan
                    // Reset Password
                    viewModel.sendResetEmail()
                    
                }
                .hSpacing(.trailing)
                // Disabling Until the Data is Entered
                .disableWithOpacity(viewModel.email.isEmpty)
            }
            .padding(.top, 20)
            .onDisappear {
                viewModel.email = ""
            }
            .alert(isPresented: $viewModel.isShowingAlert) { // Alert'i tanımlama
                Alert(
                    title: Text(viewModel.alertTitle), // Başlık
                    message: Text(viewModel.alertMessage), // Mesaj
                    dismissButton: .default(Text("Okay")) {
                        viewModel.email = ""
                        dismiss()
                    }
                )
            }
        })
        .padding(.vertical, 15)
        .padding(.horizontal, 25)
        .interactiveDismissDisabled()
    }
}
