//
//  SignUpViewViewModel.swift
//  ilacTakip
//
//  Created by Mehmet Akif Kaymak on 18.02.2024.
//
import FirebaseFirestore
import FirebaseAuth
import Foundation

class SignUpViewViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    @Published var passwordAgain = ""
    @Published var fullname = ""
    @Published var length = ""
    @Published var age = ""
    @Published var gender = ""
    @Published var errorMessage = ""
    @Published var alertTitle = ""
    @Published var showPasswordAlert = false
    @Published var isSignup = false
    
    init(){}
    
    func register(){
        guard validate() else {
            return
        }
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult,
            error in
            guard let userId = authResult?.user.uid else {
                return
            }
            self?.isSignup = true
            //insert metodu çağrılacak
            self?.insertUserRecord(id: userId)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self?.isSignup = false
            }
            
        }
        
    }
    
    private func insertUserRecord(id: String) {
        let newUser = User(id: id, email: email, fullname: fullname, length: length, age: age, gender: gender)
        
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(id)
            .setData(newUser.asDictionary())
    }
    
    private func validate() -> Bool {
        errorMessage = ""
        
        guard !fullname.trimmingCharacters(in: .whitespaces).isEmpty,
              !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty else {
                errorMessage = "Please fill in all fields."
                return false
        }
        
        guard email.contains("@") && email.contains(".") else {
            errorMessage = "Enter a valid Email address."
            return false
        }
        
        guard password.count >= 6 else {
            errorMessage = "Please set a password of 6 or more characters."
            return false
        }
        
        return true
    }
    
    func passwordMatch() -> Bool {
        errorMessage = ""
        if password == passwordAgain {
            return true
        }
        else {
            errorMessage = "Your password isnt match"
            return false
        }
    }
    
    
}
