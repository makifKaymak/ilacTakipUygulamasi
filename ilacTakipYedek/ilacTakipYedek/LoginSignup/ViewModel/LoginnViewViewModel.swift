//
//  LoginnViewViewModel.swift
//  ilacTakip
//
//  Created by Mehmet Akif Kaymak on 18.02.2024.
//
import FirebaseAuth
import Foundation

class LoginnViewViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage = ""
    
    @Published var IsError = false
    
    @Published var isLoggingin = false
    
    init(){}
    
    func login() {
        guard validate() else {
            return
        }
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
                guard let self = self else { return }
                
                if let error = error {
                    // Giriş hatası var, uygun bir mesaj gösterin
                    self.IsError = true
                    self.errorMessage = "Invalid email or password. Please try again."
                    return
                }
                
                // Giriş başarılı, diğer işlemleri yapabilirsiniz
                
        }
        isLoggingin = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.isLoggingin = false
        }
    }
     
    
    func validate()->Bool {
        errorMessage = ""
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty,
        !password.trimmingCharacters(in: .whitespaces).isEmpty
        else {
            IsError = true
            errorMessage = "Please fill in all blanks."
            return false
        }
        guard email.contains("@") && email.contains(".") else {
            IsError = true
            errorMessage = "Please enter a valid email adress."
            return false
        }
        return true
    }
}
