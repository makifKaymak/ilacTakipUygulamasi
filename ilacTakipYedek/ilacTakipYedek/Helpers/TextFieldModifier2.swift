//
//  TextFieldModifier2.swift
//  ilacTakipYedek
//
//  Created by Mehmet Akif Kaymak on 13.05.2024.
//

import SwiftUI

struct TextFieldModifier2: ViewModifier {
    func body(content: Content) -> some View {
        content
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding(.horizontal, 50)
            .overlay(
                    RoundedRectangle(cornerRadius: 3) // Yuvarlak kenarlı bir dikdörtgen ekleyin
                        .stroke(Color.pinkAccent, lineWidth: 1) // Pembe renkte ve 1 piksel kalınlığında bir çizgi oluşturun
                        .padding(.horizontal, 50)
            )
            
    }
}

