//
//  WeatherViewModelTests.swift
//  WeatherTests
//
//  Created by Sai Prasad Soma on 26/08/24.
//

import XCTest
@testable import Weather

final class WeatherViewModelTests: XCTestCase {
    var viewModel: WeatherViewModel!
    var mockWeatherService: MockWeatherService!
    
    override func setUp() {
        super.setUp()
        mockWeatherService = MockWeatherService()
        viewModel = WeatherViewModel(weatherService: mockWeatherService)
    }
    
    override func tearDown() {
        viewModel = nil
        mockWeatherService = nil
        super.tearDown()
    }
    
    func testFetchWeatherSuccess() {
        // Given
        let expectedWeatherResponse = WeatherResponse(
            main: WeatherResponse.Main(temp: 30.0),
            weather: [WeatherResponse.Weather(icon: "01d", description: "clear sky")]
        )
        mockWeatherService.weatherResponse = .success(expectedWeatherResponse)
        
        // Create an expectation
        let expectation = self.expectation(description: "Fetching weather should succeed")
        
        // When
        viewModel.fetchWeather(for: "Atlanta")
        
        // Observe changes and fulfill expectation
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            // Then
            XCTAssertEqual(self.viewModel.weather?.main.temp, 30.0)
            expectation.fulfill()
        }
        
        // Wait for the expectation to be fulfilled
        waitForExpectations(timeout: 2.0, handler: nil)
    }
    
    func testFetchWeatherFailure() {
        // Given
        let expectedError = WeatherError.noData
        mockWeatherService.weatherResponse = .failure(expectedError)
        
        // When
        viewModel.fetchWeather(for: "Atlanta")
        
        // Then
        XCTAssertNil(viewModel.weather)
    }
    
    func testLoadLastCity() {
        // Given
        UserDefaults.standard.set("Atlanta", forKey: "lastSearchedCity")
        let expectedWeatherResponse = WeatherResponse(
            main: WeatherResponse.Main(temp: 30.0),
            weather: [WeatherResponse.Weather(icon: "01d", description: "clear sky")]
        )
        mockWeatherService.weatherResponse = .success(expectedWeatherResponse)
        
        // Create an expectation
        let expectation = self.expectation(description: "Loading last city should succeed")
        
        // When
        viewModel.loadLastCity()
        
        // Observe changes and fulfill expectation
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            // Then
            XCTAssertEqual(self.viewModel.weather?.main.temp, 30.0)
            XCTAssertEqual(self.viewModel.weather?.weather.first?.description, "clear sky")
            expectation.fulfill()
        }
        
        // Wait for the expectation to be fulfilled
        waitForExpectations(timeout: 2.0, handler: nil)
    }
    
    func testErrorHandling() {
        // Given
        let expectedError = WeatherError.decodingError
        mockWeatherService.weatherResponse = .failure(expectedError)
        
        // When
        viewModel.fetchWeather(for: "Atlanta")
        
        // Then
        XCTAssertNil(viewModel.weather)
    }
    
    func testFetchWeatherEmptyResponse() {
        // Given
        let emptyWeatherResponse = WeatherResponse(main: WeatherResponse.Main(temp: 0.0), weather: [])
        mockWeatherService.weatherResponse = .success(emptyWeatherResponse)
        
        // Create an expectation
        let expectation = self.expectation(description: "Fetch weather should handle empty response")
        
        // When
        viewModel.fetchWeather(for: "Atlanta")
        
        // Observe changes and fulfill expectation
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            // Then
            XCTAssertEqual(self.viewModel.weather?.main.temp, 0.0)
            XCTAssertTrue(self.viewModel.weather?.weather.isEmpty ?? false)
            expectation.fulfill()
        }
        
        // Wait for the expectation to be fulfilled
        waitForExpectations(timeout: 2.0, handler: nil)
    }


}

// MARK: - Mock Classes

class MockWeatherService: WeatherServiceProtocol {
    var weatherResponse: Result<WeatherResponse, Error>?
    
    func fetchWeather(for city: String, completion: @escaping (Result<WeatherResponse, Error>) -> Void) {
        if let response = weatherResponse {
            completion(response)
        }
    }
}
