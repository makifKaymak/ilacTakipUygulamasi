//
//  CustomTF.swift
//  ilacTakip
//
//  Created by Mehmet Akif Kaymak on 13.02.2024.
//

import SwiftUI

struct CustomTF: View {
    
    private var sfIcon: String
    private var iconTint: Color = .gray
    private var title: String
    /// Hides TextField
    private var isPassword: Bool = false
    @Binding private var text: String
    /// View Properties
    @State private var showPassword = false
    
    var body: some View {
        HStack(alignment: .top, spacing: 8, content: {
            Image(systemName: sfIcon)
                .foregroundStyle(iconTint)
                /// Since I need Same Width to Align TextFields Equally
                .frame(width: 30)
                /// Slightly Bringing Down
                .offset(y:2)
            
            VStack(alignment: .leading, spacing: 8, content: {
                if isPassword {
                    Group {
                        /// Revealing Password when users wants to show Password
                        if showPassword {
                            TextField(title, text: $text)
                                .textInputAutocapitalization(.never)
                        } else {
                            SecureField(title, text: $text)
                        }
                    }
                } else {
                    TextField(title, text: $text)
                        .textInputAutocapitalization(.never)
                }
                Divider()
            })
            .overlay(alignment: .trailing) {
                /// Password Reveal Button
                if isPassword {
                    Button(action: {
                        withAnimation{
                            showPassword.toggle()
                        }
                    }, label: {
                        Image(systemName: showPassword ? "eye.slash" : "eye")
                            .foregroundStyle(.gray)
                            .padding(10)
                            .contentShape(.rect)
                    })
                }
            }
        })
    }
}

