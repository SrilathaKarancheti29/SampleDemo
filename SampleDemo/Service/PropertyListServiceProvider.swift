//
//  PropertyListServiceProvider.swift
//  Sample demo
//
//  Created by Srilatha Karancheti on 2022-04-07.
//

import Foundation
import CoreLocation

struct PropertyListServiceProvider: PropertiesService {
    let networkSession: FakeNetworkSession
    let select: (Property) -> Void
    let addToFavourite: (Property) -> Void
    
    func loadProperties() async throws -> [PropertyListViewModel] {
        do {
            let properties = try  networkSession.fetchPropertyList()
            return await properties.asyncMap { property in
                 await propertyListViewModel(forProperty: property)
            }
            
        } catch {
            throw error
        }
    }
    
    func propertyListViewModel(forProperty property: Property) async -> PropertyListViewModel {
        var locationPlacemark: CLPlacemark?
        let imageURL = "\(property.coverImageUrl)"
        let price = "$" + "\(property.price)"
        let size = "\(property.size.bed)bed " +
                    "\(property.size.bath)bath " +
                    "\(property.size.sqft) sqft " +
                    "\(property.age)"
        let address = "\(property.address)," + "\(property.city), ON"
        let listingId = "MLS® Listing" + "\(property.id)"
        locationPlacemark = await placemark(for: CLLocation(latitude: property.latitude, longitude: property.longitude))
        return PropertyListViewModel(price: price, size: size, address: address, listingId: listingId, imageURL: imageURL,select: {
            select(property)
        }, favorite: {
            addToFavourite(property)
        }, placemark: locationPlacemark)
    }
    
    func placemark(for location: CLLocation) async -> CLPlacemark? {
        let placemarks =  try? await CLGeocoder().reverseGeocodeLocation(location)
        return placemarks?.first
    }
}



