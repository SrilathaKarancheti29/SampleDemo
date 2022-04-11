//
//  LocationSearchService.swift
//  Sample demo
//
//  Created by Srilatha Karancheti on 2022-04-10.
//

import Foundation
import CoreLocation

enum LocationError: String, Error {
    case invalidLocation
}

struct LocationListService {
    var networkSession: FakeNetworkSession
    var currentLocation: CLLocation?

    private let geocoder = CLGeocoder()
    let select: (CLPlacemark?) -> Void
    
    func loadLocations() async throws  -> [LocationViewModel]? {
        do {
            let locations = try  networkSession.fetchSupportedLocations()
            let list = await locationViewModels(fromLocations: locations)
            return list
        } catch {
            throw error
        }
    }
    
    func locationViewModels(fromLocations locations: [SupportedLocation]) async -> [LocationViewModel] {
        var locationViewModel: [LocationViewModel] = []
        locationViewModel.append(currentLocationVM)
        
        for location in locations {
            let clLocation = CLLocation(latitude: location.latitude, longitude: location.longitude)
            let placemark = try? await placemark(for: clLocation)
            if let placemark = placemark, let city = placemark.locality, let state = placemark.administrativeArea {
              let vm =  LocationViewModel(title: "\(city), \(state)", select: {
                    select(placemark)
                }, titleColor: .black)
                locationViewModel.append(vm)
            }
        }
        return locationViewModel
    }
    
    var currentLocationVM: LocationViewModel {
        return LocationViewModel(title: "Current Location", select: {
            Task {
                if let location = currentLocation, let placemark = try? await placemark(for: location) {
                    select(placemark)
                }
            }
            
        }, titleColor: .blue)
    }
    
    func placemark(for location: CLLocation) async throws -> CLPlacemark? {
        do {
            let placemarks =  try await CLGeocoder().reverseGeocodeLocation(location)
            return placemarks.first
        } catch {
            print("Failed to reverse geocode location")
            throw error
        }
    }
    
}
