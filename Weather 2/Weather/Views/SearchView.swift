//
//  SearchView.swift
//  Weather
//
//  Created by Sai Prasad Soma on 26/08/24.
//

import SwiftUI

struct SearchView: View {
    @StateObject private var viewModel = WeatherViewModel()
    @State private var city: String = ""
    
    var theme: Theme
    
    var body: some View {
        ZStack {
            theme.backgroundColor.ignoresSafeArea()

            VStack {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(theme.textColor)
                    
                    TextField(theme.placeholderText, text: $city)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.vertical, 10)
                        .foregroundColor(theme.textColor)
                        .animation(.easeInOut(duration: 0.3), value: city)
                }
                .padding()
                
                Button(action: {
                    viewModel.fetchWeather(for: city)
                }) {
                    Text(theme.buttonText)
                        .fontWeight(.bold)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(theme.buttonColor)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                
                Spacer()
                
                if viewModel.isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .scaleEffect(1.5)
                        .padding(.top, 20)
                        .transition(.opacity)
                        .animation(.easeInOut(duration: 0.3), value: viewModel.isLoading)
                } else if let weather = viewModel.weather {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Temperature: \(weather.main.temp - 273.15, specifier: "%.1f")°C")
                            .font(.headline)
                            .foregroundColor(theme.textColor)
                        
                        Text("Description: \(weather.weather.first?.description ?? "N/A")")
                            .foregroundColor(theme.textColor)
                        
                        if let icon = weather.weather.first?.icon {
                            AsyncImage(url: URL(string: "http://openweathermap.org/img/wn/\(icon)@2x.png"))
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100, height: 100)
                                .transition(.slide)
                                .animation(.easeInOut(duration: 0.3), value: icon)
                        }
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.white).shadow(radius: 5))
                    .transition(.opacity)
                    .animation(.easeInOut(duration: 0.3), value: weather)
                } else if let errorMessage = viewModel.errorMessage {
                    Text("Error: \(errorMessage)")
                        .foregroundColor(.red)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white).shadow(radius: 5))
                        .transition(.opacity)
                        .animation(.easeInOut(duration: 0.3), value: errorMessage)
                }
                
                Spacer()
            }
            .padding()
        }
        .onAppear {
            viewModel.loadLastCity()
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(theme: .defaultTheme)
    }
}

