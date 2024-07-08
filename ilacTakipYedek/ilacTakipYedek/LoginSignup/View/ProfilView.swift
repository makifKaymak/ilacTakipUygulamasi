//
//  ProfilView.swift
//  ilacTakip
//
//  Created by Mehmet Akif Kaymak on 20.02.2024.
//

import SwiftUI

struct ProfilView: View {
    
    @StateObject var viewModel = ProfilViewViewModel()

    var body: some View {
        
        NavigationStack {
            VStack {
                if let user = viewModel.user {
                    profile(user: user)
                } else {
                    Text("Profile is loading...")
                }
                
                GradientButton(title: "SignOut", icon: "rectangle.portrait.and.arrow.right") {
                    viewModel.isSignOut = true
                    viewModel.logout()
                }
                
                GradientButton(title: "Change Password", icon: "rectangle.and.pencil.and.ellipsis") {
                    viewModel.sendPasswordResetEmail()
                }
                
                
            }
            
        }
        .sheet(isPresented: $viewModel.isSignOut, content: {
            if #available(iOS 16.4, *) {
                signOutingView()
                    .presentationDetents([.height(350)])
                    .presentationCornerRadius(30)
            } else {
                signOutingView()
                    .presentationDetents([.height(350)])
            }
        })
        .alert(isPresented: $viewModel.isPasswordResetEmailSent) {
            Alert(title: Text("!!!"), message: Text( viewModel.message), dismissButton: .default(Text("OK")){
                viewModel.isPasswordResetEmailSent = false
            })
        }
        .onAppear {
            viewModel.fetchUser()
        }
        .onDisappear {
            viewModel.isSignOut = false
        }
        
    }
        
    
    @ViewBuilder
    func profile(user: User) -> some View {
        Image(systemName: "person.circle")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .foregroundStyle(Color.blue)
            .frame(width: 125, height: 125)
        
        VStack {
            HStack {
                Text("Name: ")
                Text(user.fullname)
            }
            HStack {
                Text("Email: ")
                Text(user.email)
            }
            HStack {
                Text("Length: ")
                Text(user.length)
            }
            HStack {
                Text("Age: ")
                Text(user.age)
            }
            HStack {
                Text("Gender: ")
                Text(user.gender)
            }
            
        }
    }
}

struct signOutingView: View {
    var body: some View {
        Text("Sign out...")
            .padding()
            .cornerRadius(10)
        
    }
}

#Preview {
    ProfilView()
}
