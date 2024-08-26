//
//  LocationService.swift
//  Weather
//
//  Created by Sai Prasad Soma on 26/08/24.
//

import Foundation
import CoreLocation

protocol LocationServiceProtocol {
    func getLocation(for city: String, completion: @escaping (Result<Location, Error>) -> Void)
}

class LocationService: LocationServiceProtocol {
    func getLocation(for city: String, completion: @escaping (Result<Location, Error>) -> Void) {
        // Example of converting a city name to coordinates
        // In reality, you'd use the Geocoder API here
        let exampleLocation = Location(city: city, latitude: 40.7128, longitude: -74.0060) // New York coordinates
        completion(.success(exampleLocation))
    }
}
