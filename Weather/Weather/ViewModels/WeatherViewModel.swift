//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Sai Prasad Soma on 26/08/24.
//

import Foundation
import Combine
import CoreLocation

class WeatherViewModel: ObservableObject {
    @Published var weather: WeatherResponse?
    @Published var errorMessage: String?
    @Published var isLoading = false
    
    private let weatherService: WeatherServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(weatherService: WeatherServiceProtocol = WeatherService()) {
        self.weatherService = weatherService
        loadLastCity()
    }
    
    func fetchWeather(for city: String) {
        isLoading = true
        weatherService.fetchWeather(for: city) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let weather):
                    self?.weather = weather
                    self?.errorMessage = nil
                    self?.saveLastCity(city)
                case .failure(let error):
                    self?.weather = nil
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func loadLastCity() {
        if let lastCity = UserDefaults.standard.string(forKey: "lastCity") {
            fetchWeather(for: lastCity)
        }
    }
    
    func saveLastCity(_ city: String) {
        UserDefaults.standard.set(city, forKey: "lastCity")
    }
}
