//
//  TextFieldModifier.swift
//  ilacTakip
//
//  Created by Mehmet Akif Kaymak on 18.02.2024.
//

import SwiftUI

struct TextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.subheadline)
            .padding(12)
            .background(Color(.systemGray6))
            .clipShape(Rectangle())
            .padding(.horizontal, 24)
            .frame(maxWidth: .infinity)
    }
}
