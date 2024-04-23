//
//  Car.swift
//  CarInformation
//
//  Created by 조성빈 on 4/16/24.
//

import Foundation

class OilCar: Car, Fuel {
    var isAutomatic: Bool
    var fuelEfficiency: Double
    var isGasoline: Bool
    
    init(brand: String, modelName: String, year: Int, doorCount: Int, weight: Double, height: Double, isAutomatic: Bool, fuelEfficiency: Double, isGasoline: Bool) {
        self.isAutomatic = isAutomatic
        self.fuelEfficiency = fuelEfficiency
        self.isGasoline = isGasoline
        super.init(brand: brand, modelName: modelName, year: year, doorCount: doorCount, weight: weight, height: height)
    }
    
    override func getDetail() -> String {
        return super.getDetail() + "Automatic: \(isAutomatic), FuelEfficiency: \(fuelEfficiency), Gasoline: \(isGasoline)"
    }
}
