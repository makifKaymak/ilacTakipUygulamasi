//
//  LoggedOrNotViewViewModel.swift
//  ilacTakip
//
//  Created by Mehmet Akif Kaymak on 20.02.2024.
//

import Foundation
import FirebaseAuth

class LoggedOrNotViewViewModel: ObservableObject {
    
    @Published var currentUserId: String = ""

    init() {
        Auth.auth().addStateDidChangeListener {[weak self] _, user in
            DispatchQueue.main.async {
                self?.currentUserId = user?.uid ?? ""
            }
        }
    }
    
    public var isSignedIn: Bool {
        return Auth.auth().currentUser != nil
    }
    
    
}
