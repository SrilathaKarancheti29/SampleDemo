//
//  PropertyListViewModel.swift
//  Sample demo
//
//  Created by Srilatha Karancheti on 2022-04-07.
//

import Foundation
import CoreLocation

struct PropertyListViewModel {
    let price: String
    let size: String
    let address: String
    let listingId: String
    let imageURL: String
    let select: () -> Void
    let favorite: () -> Void
    let placemark: CLPlacemark?
}
