//
//  DateValue.swift
//  ilacTakip
//
//  Created by Mehmet Akif Kaymak on 19.02.2024.
//

import SwiftUI

// Date value Model...
struct DateValue: Identifiable {
    var id = UUID().uuidString
    var day: Int
    var date: Date
}
