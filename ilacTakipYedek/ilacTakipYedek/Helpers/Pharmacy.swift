//
//  Pharmacy.swift
//  ilacTakipYedek
//
//  Created by Mehmet Akif Kaymak on 25.05.2024.
//

import Foundation
import MapKit

struct Pharmacy: Decodable, Identifiable, Hashable {
    let id: UUID // Benzersiz kimlik
    let pharmacyName: String
    let latitude: Double
    let longitude: Double

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = UUID() // Benzersiz kimliği burada atıyoruz
        self.pharmacyName = try container.decode(String.self, forKey: .pharmacyName)
        self.latitude = try container.decode(Double.self, forKey: .latitude)
        self.longitude = try container.decode(Double.self, forKey: .longitude)
    }

    private enum CodingKeys: String, CodingKey {
        case pharmacyName = "pharmacyName"
        case latitude = "latitude"
        case longitude = "longitude"
    }
}

struct PharmacyResponse: Decodable {
    let data: [Pharmacy]
}
