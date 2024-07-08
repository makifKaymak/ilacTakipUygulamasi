//
//  View+Extensions.swift
//  ilacTakip
//
//  Created by Mehmet Akif Kaymak on 13.02.2024.
//

import SwiftUI

///Custom SwiftUI View Extensions

extension View {
    ///View Alignmnets
    @ViewBuilder
    func hSpacing(_ alignment: Alignment = .center) -> some View {
        self
            .frame(maxWidth: .infinity, alignment: alignment)
    }
    func vSpacing(_ alignment: Alignment = .center) -> some View {
        self
            .frame(maxHeight: .infinity, alignment: alignment)
    }
    /// Disable With Opacity
    @ViewBuilder
    func disableWithOpacity(_ condition: Bool) -> some View {
        self
            .disabled(condition)
            .opacity(condition ? 0.5 : 1)
    }
}
