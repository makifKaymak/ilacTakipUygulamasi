//
//  SecureFieldViewButton.swift
//  ilacTakip
//
//  Created by Mehmet Akif Kaymak on 18.02.2024.
//

import SwiftUI

struct SecureFieldViewButton: View {
    @Binding private var text: String
    @State private var isSecured: Bool = true
    private var title: String
    
    init(_ title: String, text: Binding<String>) {
        self._text = text
        self.title = title
    }
    
    var body: some View {
        ZStack(alignment: .trailing) {
            Group {
                if isSecured {
                    SecureField(title, text: $text)
                        .modifier(TextFieldModifier())
                } else {
                    TextField(title, text: $text)
                        .modifier(TextFieldModifier())
                }
            }
            Button {
                isSecured.toggle()
            } label: {
                Image(systemName: self.isSecured ? "eye.slash" : "eye")
                    .tint(.gray)
            }
            .padding(.trailing, 36)
            
        }
    }
}

#Preview {
    SecureFieldViewButton("Password", text: .constant(""))
}
