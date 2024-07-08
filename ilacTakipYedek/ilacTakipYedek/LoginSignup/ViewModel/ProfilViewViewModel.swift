//
//  ProfilViewViewModel.swift
//  ilacTakip
//
//  Created by Mehmet Akif Kaymak on 20.02.2024.
//
import FirebaseAuth
import FirebaseFirestore
import Foundation

class ProfilViewViewModel: ObservableObject {
    
    @Published var user: User? = nil
    @Published var isSignOut = false
    @Published var userEmail: String?
    @Published var isPasswordResetEmailSent = false
    @Published var message = ""
    
    init() {}
    
    func fetchUser() {
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(userId).getDocument { [weak self] snapshot, error in
                guard let data = snapshot?.data(), error == nil else {
                    return
                }
                DispatchQueue.main.async {
                    self?.user = User(
                        id: data["id"] as? String ?? "",
                        email: data["email"] as? String ?? "",
                        fullname: data["fullname"] as? String ?? "",
                        length: data["length"] as? String ?? "",
                        age: data["age"] as? String ?? "",
                        gender: data["gender"] as? String ?? ""
                    )
                    self?.userEmail = self?.user?.email
                }
            }
        
    }
    
    func logout() {
        do {
            try Auth.auth().signOut()
        } catch {
            print(error)
        }
    }
    
    func sendPasswordResetEmail() {
            if let userEmail = userEmail {
                Auth.auth().sendPasswordReset(withEmail: userEmail) { error in
                    if let error = error {
                        print("Error sending password reset email: \(error.localizedDescription)")
                        return
                    }
                    self.isPasswordResetEmailSent = true
                    self.message = "Password reset email sent to \(userEmail)"
                    print("Password reset email sent to \(userEmail)")
                }
            } else {
                print("User email is nil.")
            }
        }
    
}
