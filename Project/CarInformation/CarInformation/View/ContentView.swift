//
//  ContentView.swift
//  CarInformation
//
//  Created by 조성빈 on 4/16/24.
//

import SwiftUI

struct ContentView: View {
    
    let cars: [String] = ["전기", "내연기관", "하이브리드"]
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(cars, id: \.self) { car in
                        NavigationLink(destination: CarListView(carType: car)) {
                            Text(car)
                        }
                    }
//                    Section(header: Text("전기")) {
//                        ForEach(carArray.filter { $0 is ElectricCar }, id: \.id) { car in
//                            Text(car.modelName)
//                        }
//                    }
                }
            }
            .navigationTitle("TopGear")
        }
    }
}

#Preview {
    ContentView()
}
