//
//  WeatherCoordinator.swift
//  Weather
//
//  Created by Sai Prasad Soma on 26/08/24.
//

import SwiftUI

class WeatherCoordinator {
    let dependencyInjector: DependencyInjector
    
    init(dependencyInjector: DependencyInjector) {
        self.dependencyInjector = dependencyInjector
    }
    
    func start() -> some View {
        return SearchView(theme: .clientXTheme)
    }
}
