//
//  GradientButton.swift
//  ilacTakip
//
//  Created by Mehmet Akif Kaymak on 13.02.2024.
//

import SwiftUI

struct GradientButton: View {
    var title: String
    var icon: String
    var onClick: () -> ()
    var body: some View {
        Button(action: onClick, label: {
            HStack(spacing: 15) {
                Text(title)
                Image(systemName:  icon)
            }
            .fontWeight(.bold)
            .foregroundStyle(.renk)
            .padding(.vertical, 12)
            .padding(.horizontal, 35)
            .background(Color.pinkAccent, in: .capsule)
            
        })
        
    }
}


