//
//  FakeNetworkSession.swift
//  Sample demo
//
//  Created by Srilatha Karancheti on 2022-04-07.
//

import Foundation
import UIKit

enum PropertyFetchError: String, Error {
    case requestFailed = "Failed to process your request.Please try again later."
}

enum LocationsFetchError: String, Error {
    case requestFailed = "Failed to retrieve supported locations.Please try again later."
}

class FakeNetworkSession {
    
    static let shared = FakeNetworkSession()
    private var cache = NSCache<NSString, UIImage>()
    
    var fileURL: URL {
        let path = Bundle.main.path(forResource: "Response", ofType: "json")!
        return URL(fileURLWithPath: path)
    }
    
    func fetchPropertyList() throws -> [Property] {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        //jsonDecoder.dataDecodingStrategy = .base64
        let data = try! Data(contentsOf: fileURL)
        do {
            let propertyList = try jsonDecoder.decode(PropertyList.self, from: data)
            return propertyList.properties
        } catch {
            print(error.localizedDescription)
            throw PropertyFetchError.requestFailed
        }
    }
    
    func downloadImage(fromURLString urlString: String) async -> UIImage? {
        let cacheKey = NSString(string: urlString)
        if let image = cache.object(forKey: cacheKey) {
            return image
        }
        guard let url = URL(string: urlString) else { return nil}
        
        do {
            let (data,_) = try await URLSession.shared.data(from: url)
            guard let image = UIImage(data: data) else { return  nil}
            cache.setObject(image, forKey: cacheKey)
            return image
        } catch {
            return nil
        }
    }
    
    func fetchSupportedLocations() throws -> [SupportedLocation] {
        let jsonDecoder = JSONDecoder()
        let path = Bundle.main.path(forResource: "SupportedLocationsResponse", ofType: "json")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: path))
        do {
            let locations = try jsonDecoder.decode(Locations.self, from: data)
            return locations.supportedLocations
        } catch {
            print(error.localizedDescription)
            throw LocationsFetchError.requestFailed
        }
    }

}
