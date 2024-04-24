//
//  ContentView.swift
//  StaticList
//
//  Created by Jungman Bae on 4/24/24.
//

import SwiftUI


struct ContentView: View {
    var weatherData: [WeatherInfo]
    
    var body: some View {
        List {
            ForEach(weatherData) { weather in
                WeatherRow(weather: weather)
            }
        }
    }
}

#Preview {
    ContentView(weatherData: WeatherInfo.weatherData)
}
