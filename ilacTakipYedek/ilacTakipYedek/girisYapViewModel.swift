//
//  girisYapViewModel.swift
//  ilacTakip
//
//  Created by Mehmet Akif Kaymak on 9.01.2024.
//

import Foundation
import SwiftUI

extension girisYap {
    class ViewModel: ObservableObject {
        @AppStorage("AUTH_KEY") var authenticated = false {
            willSet {objectWillChange.send()}
        }
        @AppStorage("USER_NAME") var name = "name"
        @AppStorage("USER_SNAME") var surname = "surname"
        @AppStorage("USER_KEY") var username = "username"
        @Published var password = "password"
        @Published var invalid: Bool = false
        
        //Bunlar kullanıcıadı ve Şifremiz
        private var sampleName = "Ad"
        private var sampleSurname = "Soyad"
        private var sampleUser = "kullanıcı adı"
        private var samplePassword = "şifre"
        
        init() {
            print("Currently logged on: \(authenticated)")
            print("Currently user: \(username)")
        }
        
        func toggleAuthentication() {
            self.password = ""
            
            withAnimation {
                authenticated.toggle()
            }
        }
        
        func authenticate() {
            guard self.username.lowercased() == sampleUser else {
                self.invalid = true
                return
            }
            
            guard self.password.lowercased() == samplePassword else {
                self.invalid = true
                return
            }
            
            toggleAuthentication()
        }
        
        func logOut() {
            toggleAuthentication()
        }
        
        func logPressed() {
            print("Button Pressed")
        }
     }
}
