//
//  CarListView.swift
//  CarInformation
//
//  Created by 조성빈 on 4/16/24.
//

import SwiftUI

//enum typeOfCar: String {
//    
//}

struct CarListView: View {
    
    var carType: String
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(carAry[carType == "내연기관" ? "oil" : carType == "전기" ? "electric" : "hybrid"]!) { car in
                        NavigationLink(destination: CarDetailView()) {
                            VStack {
                                Text(car.brand)
                                Text(car.modelName)
                                Text(car.getDetail())
                            }
                        }
                    }
                }
            }
            .navigationTitle(carType)
        }
    }
}
