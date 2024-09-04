//
//  AppCoordinator.swift
//  Weather
//
//  Created by Sai Prasad Soma on 26/08/24.
//

import SwiftUI

class AppCoordinator {
    let window: UIWindow
    let dependencyInjector: DependencyInjector
    
    init(window: UIWindow, dependencyInjector: DependencyInjector) {
        self.window = window
        self.dependencyInjector = dependencyInjector
    }
    
    func start() {
        let weatherCoordinator = WeatherCoordinator(dependencyInjector: dependencyInjector)
        let rootView = weatherCoordinator.start()
        window.rootViewController = UIHostingController(rootView: rootView)
        window.makeKeyAndVisible()
    }
}
