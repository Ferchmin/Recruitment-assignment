//
//  FAAddress.swift
//  Fara
//
//  Created by Paweł Zgoda-Ferchmin on 10/04/2021.
//

import Foundation

struct FAAddress: Codable {
    let street: String
    let suite: String
    let city: String
    let zipCode: String
    let coordinates: FACoordinates

    private enum CodingKeys: String, CodingKey {
        case street
        case suite
        case city
        case zipCode = "zipcode"
        case coordinates = "geo"
    }
}

struct FACoordinates: Codable {
    private let latitudeString: String
    private let longitudeString: String

    var latitude: Double? {
        Double(latitudeString)
    }
    var longitude: Double? {
        Double(longitudeString)
    }

    private enum CodingKeys: String, CodingKey {
        case latitudeString = "lat"
        case longitudeString = "lng"
    }
}
