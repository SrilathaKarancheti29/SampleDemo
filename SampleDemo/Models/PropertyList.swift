//
//  PropertyListModel.swift
//  Sample demo
//
//  Created by Srilatha Karancheti on 2022-04-07.
//

import Foundation

struct PropertyList: Codable {
    let properties: [Property]
}

struct Property: Codable {
    let id: String
    let coverImageUrl: String
    let gallery: [String]
    let latitude: Double
    let longitude: Double
    let address: String
    let city: String
    let propertyStatus: String
    let description: String
////    let dateAdded: Date
////    let dateUpdated: Date
    let walkScore: Int
    let type: String
    let age: String
    let price: Double
    let size: Size
}

struct Size: Codable {
    let bed: Int
    let bath: Int
    let sqft: Int
}
