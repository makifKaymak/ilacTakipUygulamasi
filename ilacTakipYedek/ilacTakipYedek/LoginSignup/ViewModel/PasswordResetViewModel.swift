//
//  PasswordResetViewModel.swift
//  ilacTakipYedek
//
//  Created by Mehmet Akif Kaymak on 12.04.2024.
//

import Foundation
import FirebaseAuth

class PasswordResetViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var isShowingAlert = false
    @Published var alertTitle = ""
    @Published var alertMessage = ""
    
    init(){}
    
    func sendResetEmail() {
        guard validate() else {
            return
        }
        
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                //print("Şifre sıfırlama isteği başarısız oldu: \(error.localizedDescription)")
                self.alertTitle = "Error"
                self.alertMessage = "Password reset request failed: \(error.localizedDescription)"
                
            } else {
                //print("Şifre sıfırlama isteği başarıyla gönderildi.")
                self.alertTitle = "Success"
                self.alertMessage = "Password reset request success."
                
            }
            self.isShowingAlert = true
        }
         
    }
    
    private func validate()->Bool {
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty
        else {
            return false
        }
        return true
    }
}
