//
//  Theme.swift
//  Weather
//
//  Created by Sai Prasad Soma on 26/08/24.
//

import SwiftUI

struct Theme {
    var backgroundColor: Color
    var textColor: Color
    var buttonColor: Color
    var placeholderText: String
    var buttonText: String
    var clientName: String
}

extension Theme {
    static let defaultTheme = Theme(
        backgroundColor: Color.blue.opacity(0.3),
        textColor: Color.white,
        buttonColor: Color.blue,
        placeholderText: "Enter city",
        buttonText: "Get Weather",
        clientName: "Default"
    )
    
    static let clientXTheme = Theme(
        backgroundColor: Color.green.opacity(0.3),
        textColor: Color.black,
        buttonColor: Color.green,
        placeholderText: "Search location",
        buttonText: "Search Weather",
        clientName: "ClientX"
    )
}

