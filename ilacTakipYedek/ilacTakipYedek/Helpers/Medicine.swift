//
//  Medicine.swift
//  ilacTakip
//
//  Created by Mehmet Akif Kaymak on 16.03.2024.
//

import Foundation

struct Medicine: Codable, Identifiable {
    var id: String
    var documentId: String
    var date: String
    var medicineName: String
    var medicineType: String
    var frequencyOfTakingTheDrug: String
    var time: String
    var remindType: String
    var properties: String
}
