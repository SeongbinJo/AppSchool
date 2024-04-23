//
//  CarModel.swift
//  CarInformation
//
//  Created by 조성빈 on 4/16/24.
//

import Foundation

class Car: Identifiable, CarDescriptionProtocol {
    let id = UUID()
    var brand: String
    var modelName: String
    var year: Int
    var doorCount: Int
    var weight: Double
    var height: Double
    
    init(brand: String, modelName: String, year: Int, doorCount: Int, weight: Double, height: Double) {
        self.brand = brand
        self.modelName = modelName
        self.year = year
        self.doorCount = doorCount
        self.weight = weight
        self.height = height
    }
    
    func getDetail() -> String {
        return "Brand: \(brand), Model: \(modelName), Year: \(year)"
    }
}
