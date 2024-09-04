//
//  ErrorHandling.swift
//  Weather
//
//  Created by Sai Prasad Soma on 26/08/24.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}
