//
//  SignupView.swift
//  ilacTakip
//
//  Created by Mehmet Akif Kaymak on 13.02.2024.
//

import SwiftUI
import FirebaseAuth

struct SignupView: View {
    
    @Binding var showSignup: Bool
    @StateObject var viewModel = SignUpViewViewModel()

    var body: some View {
        ScrollView {
            VStack(alignment: .leading,spacing: 15, content: {
                // Back Button
                Button(action: {
                    showSignup = false
                }, label: {
                    Image(systemName: "arrow.left")
                        .font(.title2)
                        .foregroundStyle(.gray)
                })
                .padding(.top, 10)
                if !viewModel.errorMessage.isEmpty {
                    Text(viewModel.errorMessage)
                        .foregroundStyle(.red)
                }
                    
                
                Text("SignUp")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .padding(.top, 25)
                
                Text("Please sign up to continue")
                    .font(.callout)
                    .fontWeight(.semibold)
                    .foregroundStyle(.gray)
                    .padding(.top, -5)
                
                VStack(spacing: 25) {
                    /// Custom Text Fields
                    
                    TextField("Fullname", text: $viewModel.fullname)
                        .modifier(TextFieldModifier())
                    TextField("Email", text: $viewModel.email)
                        .modifier(TextFieldModifier())
                        .textInputAutocapitalization(.never)
                    SecureFieldViewButton("Password", text: $viewModel.password)
                    SecureFieldViewButton("Confirm Your Password", text: $viewModel.passwordAgain)
                    TextField("Length", text: $viewModel.length)
                        .modifier(TextFieldModifier())
                    TextField("Gender", text: $viewModel.gender)
                        .modifier(TextFieldModifier())
                    TextField("Age", text: $viewModel.age)
                        .modifier(TextFieldModifier())
                    
                    // SignUp Button
                    
                    GradientButton(title: "Continue", icon: "arrow.right") {
                        if viewModel.passwordMatch() {
                            viewModel.register()
                        } else {
                            viewModel.showPasswordAlert = true
                        }
                        
                    }
                    .padding(.horizontal, 24)
                    .hSpacing(.trailing)
                    // Disabling Until the Data is Entered
                    .disableWithOpacity(viewModel.email.isEmpty || viewModel.password.isEmpty || viewModel.fullname.isEmpty)
                }
                .padding(.top, 20)
                .padding(.horizontal, -24)
                Spacer(minLength: 0)
                
                HStack(spacing: 6) {
                    Text("Already have an account?")
                        .foregroundStyle(.gray)
                    
                    Button("Login") {
                        showSignup = false
                    }
                    .fontWeight(.bold)
                    .tint(.pinkAccent)
                }
                .font(.callout)
                .hSpacing()
            })
            .sheet(isPresented: $viewModel.isSignup, content: {
                if #available(iOS 16.4, *) {
                    signUpingView()
                        .presentationDetents([.height(350)])
                        .presentationCornerRadius(30)
                } else {
                    signUpingView()
                        .presentationDetents([.height(350)])
                    
                }
            })
            .alert(isPresented: $viewModel.showPasswordAlert) {
                Alert(
                    title: Text(viewModel.alertTitle), // Başlık
                    message: Text(viewModel.errorMessage), // Mesaj
                    dismissButton: .default(Text("Ok")))
            }
            .padding(.vertical, 15)
            .padding(.horizontal, 25)
        .toolbar(.hidden, for: .navigationBar)
        }
    }
    
}


struct signUpingView: View {
    var body: some View {
        Text("Trying the sign up please wait...")
            .padding()
            .cornerRadius(10)
    }
}

#Preview {
    SignupView(showSignup: .constant(false))
}
