//
//  ContentView.swift
//  Weather
//
//  Created by Sai Prasad Soma on 26/08/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel: WeatherViewModel

    var body: some View {
        WeatherView(viewModel: viewModel)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = WeatherViewModel(weatherService: WeatherService())
        ContentView(viewModel: viewModel)
    }
}
