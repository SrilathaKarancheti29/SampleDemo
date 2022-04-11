//
//  SupportedLocations.swift
//  Sample demo
//
//  Created by Srilatha Karancheti on 2022-04-10.
//

import Foundation
import CoreLocation

struct Locations: Codable {
    let supportedLocations: [SupportedLocation]
}

struct SupportedLocation: Codable {
    let id: String
    let latitude: Double
    let longitude: Double
}

extension SupportedLocation {
    struct locationMetaData: Codable {
        let city: String
        let province: String
        let country: String
    }
}
