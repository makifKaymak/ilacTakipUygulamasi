//
//  girisYap.swift
//  ilacTakip
//
//  Created by Mehmet Akif Kaymak on 9.01.2024.
//

import SwiftUI

struct girisYap: View {
    @State var girisSekmesi = true
    @StateObject var vm = ViewModel()
    
    var body: some View {
        if !vm.authenticated {
            VStack(spacing: 20) {
                AnaEkran()
            }
        } else {
            ZStack {
                Image("pillWallpaper")
                    .resizable()
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .ignoresSafeArea()
                VStack(spacing: 16){
                    Picker(selection: $girisSekmesi,
                           label: Text ("")) {
                        Text("Giriş Yap").tag(true)
                        Text("Kayıt Ol").tag(false)
                    }
                           .pickerStyle(SegmentedPickerStyle())
                    Spacer()
                }
                if girisSekmesi {
                    VStack(alignment: .leading, spacing: 20) {
                        Spacer()
                        Text("Login")
                            .foregroundStyle(.black)
                            .font(.system(size: 50, weight: .medium, design: .rounded))
                        TextField("Username", text: $vm.username)
                            .textFieldStyle(.roundedBorder)
                            .textInputAutocapitalization(.never)
                        SecureField("Password", text: $vm.password)
                            .textFieldStyle(.roundedBorder)
                            .textInputAutocapitalization(.never)
                            .privacySensitive()
                        HStack {
                            Spacer()
                            Button("Forgot Password?", action: vm.logPressed)
                                .tint(.black.opacity(0.8))
                            Spacer()
                            Button("Login", action: vm.authenticate)
                                .buttonStyle(.bordered)
                            Spacer()
                        }
                        Spacer()
                    }
                    .alert("Login Failed", isPresented: $vm.invalid){
                        Button("Okay", action: vm.logPressed)
                    }
                    .frame(width: 300)
                    .padding()
                }
                
                if !girisSekmesi {
                    VStack(alignment: .leading, spacing: 20) {
                        Spacer()
                        Text("SignUp")
                            .foregroundStyle(.black)
                            .font(.system(size: 50, weight: .medium, design: .rounded))
                        TextField("Name", text: $vm.name)
                            .textFieldStyle(.roundedBorder)
                            .textInputAutocapitalization(.never)
                        TextField("Surname", text: $vm.surname)
                            .textFieldStyle(.roundedBorder)
                            .textInputAutocapitalization(.never)
                        TextField("Username", text: $vm.username)
                            .textFieldStyle(.roundedBorder)
                            .textInputAutocapitalization(.never)
                        SecureField("Password", text: $vm.password)
                            .textFieldStyle(.roundedBorder)
                            .textInputAutocapitalization(.never)
                            .privacySensitive()
                        HStack {
                            Spacer()
                            Button("SignUp", action: vm.authenticate) //vm.kayıtol olarak değişcek
                                .buttonStyle(.bordered)
                            Spacer()
                        }
                        Spacer()
                    }
                    .alert("Login Failed", isPresented: $vm.invalid){
                        Button("Okay", action: vm.logPressed)
                    }
                    .frame(width: 300)
                    .padding()
                }
                
            }
            .transition(.offset(x:0, y: 850))
        }
    }
}

#Preview {
    girisYap()
}
