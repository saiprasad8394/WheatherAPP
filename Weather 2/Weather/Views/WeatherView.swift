//
//  WeatherView.swift
//  Weather
//
//  Created by Sai Prasad Soma on 26/08/24.
//

import SwiftUI

struct WeatherView: View {
    @ObservedObject var viewModel: WeatherViewModel
    
    var body: some View {
        VStack {
            if let weather = viewModel.weather {
                Text("Temperature: \(weather.main.temp)°C")
                Text("Description: \(weather.weather.last?.description ?? "No Description Found!!")")
                Image(systemName: weather.weather.last?.icon ?? "")
            } else if let errorMessage = viewModel.errorMessage {
                Text("Error: \(errorMessage)").foregroundColor(.red)
            } else {
                Text("Loading...")
            }
        }
        .onAppear {
            viewModel.fetchWeather(for: "New York") // Default city
        }
    }
}
