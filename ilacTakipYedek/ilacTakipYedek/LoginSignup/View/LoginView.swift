//
//  LoginView.swift
//  ilacTakip
//
//  Created by Mehmet Akif Kaymak on 13.02.2024.
//

import SwiftUI
import FirebaseAuth

struct LoginView: View {
    
    @Binding var showSignup: Bool
    @State private var showResetView = false
    @State private var navigated = false
    
    @StateObject var viewModel = LoginnViewViewModel()
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading,spacing: 15, content: {
                Spacer(minLength: 0)
                
                Text("Login")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .padding(.horizontal, 24)
                
                Text("Please sign in to continue")
                    .font(.callout)
                    .fontWeight(.semibold)
                    .foregroundStyle(.gray)
                    .padding(.top, -5)
                    .padding(.horizontal, 24)
                
                VStack(spacing: 25) {
                    // Text Fields
                    
                    TextField("Email", text: $viewModel.email)
                        .modifier(TextFieldModifier())
                        .textInputAutocapitalization(.never)
                    
                    SecureFieldViewButton("Password", text: $viewModel.password)
                    
                    Button("Forgot Password?"){
                        showResetView.toggle()
                    }
                    .font(.callout)
                    .fontWeight(.heavy)
                    .tint(.pinkAccent)
                    .hSpacing(.trailing)
                    .padding(.trailing, 24)
                    
                    GradientButton(title: "Login", icon: "arrow.right") {
                        viewModel.login()
                    }
                    .padding(.horizontal, 24)
                    .hSpacing(.trailing)
                    /// Disabling Until the Data is Entered
                    .disableWithOpacity(viewModel.email.isEmpty || viewModel.password.isEmpty)
                }
                .padding(.top, 20)
                
                Spacer(minLength: 0)
                
                HStack(spacing: 6) {
                    Text("Don't have an account?")
                        .foregroundStyle(.gray)
                    
                    Button("SignUp") {
                        showSignup.toggle()
                    }
                    .fontWeight(.bold)
                    .tint(.pinkAccent)
                }
                .font(.callout)
                .hSpacing()
            })
            .padding(.vertical, 10)
            .toolbar(.hidden, for: .navigationBar)
            .sheet(isPresented: $viewModel.isLoggingin, content: {
                if #available(iOS 16.4, *) {
                    LoggininView()
                        .presentationDetents([.height(350)])
                        .presentationCornerRadius(30)
                } else {
                    LoggininView()
                        .presentationDetents([.height(350)])
                    
                }
            })
            .sheet(isPresented: $showResetView, content: {
                if #available(iOS 16.4, *) {
                    PasswordResetView()
                        .presentationDetents([.height(350)])
                        .presentationCornerRadius(30)
                } else {
                    PasswordResetView()
                        .presentationDetents([.height(350)])
                    
                }
            })
            .navigationDestination(isPresented: $navigated){
                HomeView()
            }
            .navigationBarBackButtonHidden(true)
            .alert(isPresented: $viewModel.IsError) {
                Alert(title: Text("Error"), message: Text( viewModel.errorMessage), dismissButton: .default(Text("OK")))
                        }
            
        }
    }
}

struct LoggininView: View {
    var body: some View {
        Text("Trying the login in please wait...")
            .padding()
            .cornerRadius(10)
    }
}

#Preview {
    LoginView(showSignup: .constant(false))
}
